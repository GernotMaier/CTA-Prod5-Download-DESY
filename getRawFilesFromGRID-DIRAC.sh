#!/bin/bash
#
# simple script to download raw files from the GRID
# using DIRAC tools
# (adjusted to DESY environment)
#
#

if [ $# -lt 3 ]; then
echo "

./getRawFilesFromGRID-DIRAC.sh <run list> <target directory> <max files (100)>

download using DIRAC tools
(adjusted to DESY environment)
"
exit
fi

PDIR=`pwd`

if [ -e ${2} ]
then
   mkdir -p ${2}
fi

if [ ! -e ${1} ]; then
  echo "error: file list not found: ${1}"
  exit
fi

# temporary directory for file lists
FFN=`basename $1`
mkdir -p ${2}/tmplists

# loop over all files in the list
NTMPLIST=`wc -l $1 | awk '{print $1}'`
FILEN=${3}
for ((l = 1; l < $NTMPLIST; l+=$FILEN ))
do
# create file lists with $FILEN files each
   let "k = $l + $FILEN - 1"
   let "z = $z + 1"
   LLIST=$2/tmplists/$FFN.tmplist.d.$z.list
   echo $LLIST
   sed -n "$l,$k p" $1 > $LLIST

   # check if files are on disk
   FF=`cat $LLIST`
   LFIST=$FFN.tmplist.f.$z.list
   touch $2/tmplists/$LFIST
   for F in $FF
   do
      FIL=`basename $F`
      if [ ! -e $2/$FIL ]
      then
          echo $F >> $2/tmplists/$LFIST
      fi
   done
   NWC=`wc -l $2/tmplists/$LFIST | awk {'print $1'}`

   echo $NWC

   if [ "$NWC" -gt 0 ]
   then
      # run dirac get files
      echo "Downloading $NWC files"
      cd ${2}
      if [[ -e tmplists/$LFIST ]]; then
          dirac-dms-get-file tmplists/$LFIST
      else
          echo "File list not found: tmplists/$LFIST"
      fi
   fi
   cd ${PDIR}
done

cd ${PDIR}

exit
