#!/bin/bash
#
# copy DLX files from dCache (!!) files to target directory
# 
#

if [ $# -eq 0 ]; then
   echo "./copy_DLXfiles_from_dCache.sh <production>"
fi

FLIST=$(cat ${1}.list)

for P in $FLIST
do
   if [[ ${P} == *"gamma-diffuse"* ]]; then
        PP="gamma_cone"
   elif [[ ${P} == *"gamma"* ]]; then
        PP="gamma_onSource"
   elif [[ ${P} == *"proton"* ]]; then
        PP="proton"
   elif [[ ${P} == *"electron"* ]]; then
        PP="electron"
   else
        echo "unknown particle in $P"
        continue
   fi

   # directory per particle type
   mkdir -p ${1}/${PP}

   FF=$(cat ${1}/${P}.dCache.list)

   for F in $FF
   do
      FP=$(basename $F)
      if [[ ! -e ${1}/${PP}/${FP} ]]; then
          cp -v /pnfs/ifh.de/${F} ${1}/${PP}/
      fi
   done
done
