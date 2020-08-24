#!/bin/bash
#
# copy DL1 files from tar in dCache (!!) files to target directory
# 
# ./copy_DL1files.sh
#

if [ $# -eq 0 ]; then
   echo "./copy_DL1files.sh copy"
   echo
   echo "note the hardwired values"
fi

# hardwired values
DSET="Prod5_LaPalma_AdvancedBaseline_NSB1x"
PLIST="gamma_onSource gamma_cone proton"
PLIST="gamma_onSource gamma_cone proton electron"
# targetdir
OSET="prod5-LaPalma-20deg-EVNDISP"
########################
# list of arrays
# South
# declare -a ARRAY=("BL-0LSTs15MSTs50SSTs-MSTF" "BL-0LSTs15MSTs50SSTs-MSTN" "BL-4LSTs25MSTs70SSTs-MSTF" "BL-4LSTs25MSTs70SSTs-MSTN" )
# North
declare -a ARRAY=("BL-4LSTs05MSTs-MSTF" "BL-4LSTs09MSTs-MSTF" "BL-4LSTs15MSTs-MSTF" ) 

for P in $PLIST
do
   if [[ ${P} == *"gamma_cone"* ]]; then
        PP="gamma-diffuse"
   elif [[ ${P} == "gamma_onSource" ]]; then
        PP="gamma"
   elif [[ ${P} == *"proton"* ]]; then
        PP="proton"
   elif [[ ${P} == *"electron"* ]]; then
        PP="electron"
   else
        echo "unknown particle in $P"
        continue
   fi
   for A in "${ARRAY[@]}"
   do
      # files are copied here
      ODIR=${CTA_USER_DATA_DIR}/analysis/AnalysisData/${OSET}/N.${A}/EVNDISP/$P
      echo $ODIR
      mkdir -p ${ODIR}
      for D in North South
      do
        FLIST=${DSET}/${DSET}_${PP}_${D}_20deg_DL1.dCache.list
        FF=$(cat ${FLIST})
        for F in $FF
        do
           echo $F ${A}
           dccp ${F} tt.tar.gz
           tar --overwrite -C ${ODIR} -xvzf tt.tar.gz --wildcards "*${A}*"
           rm -f tt.tar.gz
        done 
      done
   done
done
