#!/bin/bash
#
# copy DL1 files from tar files to target directory
# 
# ./copy_DL1files.sh
#

if [ $# -eq 0 ]; then
   echo "./copy_DL1files.sh copy"
   echo
   echo "note the hardwired values"
fi

# hardwired values
DSET="Prod5_LaPalma_AdvancedBaseline_NSB1x_DL1"
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
declare -a ARRAY=("BL-4LSTs15MSTs-MSTN" )

for P in $PLIST
do
   for A in "${ARRAY[@]}"
   do
       # files are copied here
       ODIR=${CTA_USER_DATA_DIR}/analysis/AnalysisData/${OSET}/N.${A}/EVNDISP/$P
       echo $ODIR
       mkdir -p ${ODIR}
       find ${DSET}/$P -name "*.tar.gz" -print -exec tar --overwrite -C ${ODIR} -xvzf {} --wildcards "*${A}*" \;
   done
done
