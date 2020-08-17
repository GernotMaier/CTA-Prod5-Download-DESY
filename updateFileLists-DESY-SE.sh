#!/bin/bash
#
# simple script to update list of files produced by dirac tools and
# - prepare a list of all files which are on the DESY dCache
# - prepare a list of all files which are not on the DESY dCache
#

if [ $# -lt 3 ]; then
   echo "./updateFileLists-DESY-SE.sh <dset name> <file list> <particle type>"
   echo
   echo ".e.g for Paranal_proton_South_20deg_HB9 do: "
   echo "./CTA.prepareDownloadLists-DIRAC.sh Paranal 20deg_HB9 <data directory>"
   exit
fi

# data set
FFN=${1}
# file list
FL=${2}
# particle type
P=${3}

# dcache client
export DCACHE_CLIENT_ACTIVE=1

echo ${FFN}

# data directories
DDIR="${FFN}/${P}/"
echo "    Data directory ${DDIR}"
echo "    Filelist ${FL}"

#####################
# output file lists:

# list of files on dCache
FDC=${FFN}/${FL}.dCache.list
rm -f $FDC
touch $FDC
# list of files not downloaded yet (one some GRID SE)
FGR=${FFN}/${FL}.GRID.list
rm -f $FGR
touch $FGR
# list of available files (dCache + lustre)
FGA=${FFN}/${FL}.local.list
rm -f $FGA
touch $FGA

# loop over all files in the list
#        FILEL=`cat ${FFN}.GRID.list.back`
FILEL=`cat ${FFN}/${FL}.list`
for i in $FILEL
do
    OFIL=`basename $i`
    if [ -e $DDIR/$OFIL ] && [ -s $DDIR/$OFIL ]
    then
       echo "FILE EXISTS: $DDIR/$OFIL"
       # full path
       FFGA=$(readlink -f $DDIR/$OFIL)
       echo ${FFGA} >> $FGA
    else
       # check if it is stored locally on the dcache
       DC="/acs/grid/cta/$i"
       if [ -e $DC ]
       then
          echo /acs/grid/cta/$i >> $FDC
          echo /acs/grid/cta/$i >> $FGA
       else
          echo $i >> $FGR
       fi
    fi
done

exit
