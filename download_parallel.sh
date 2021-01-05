#!/bin/bash
#
# simple script which allows to download
# all particle types simulatenously
#

# Prod5 NSB 1x
DD="Prod5_Paranal_AdvancedBaseline_NSB1x"
# Prod4b SST production
DD="Prod4b_Paranal"
# Prod4b SST production
DD="Prod3b_Paranal"
# Prod5 NSB 1x
DD="Prod5b_LaPalma_AdvancedBaseline_NSB1x"
# Prod3B SCT DL1
DD="Prod3b_Paranal_20deg_HB9_SCT_DL1"

ZE="20deg"
DL="DL0"
SCT="FALSE"
if [[ $DD == *"Prod3b_Paranal"* ]]; then
  DL="HB9"
  DL="HB9_SCT_DL1"
  SCT="TRUE"
fi

mkdir -p tmp_log

for P in proton gamma_cone gamma_onSource electron
do
     if [[ ${P} == "gamma_cone" ]]; then
         PP="gamma-diffuse"
     elif [[ ${P} == "gamma_onSource" ]]; then
         PP="gamma"
     else
         PP=${P}
     fi

     for A in North South
     do
         rm -f tmp_log/${P}_${A}.log
         # Prod4b SST production
         if [[ $DD = *"Prod4"* ]]; then
            if [[ $A == "South" ]]; then
               continue
            fi
            for S in "sst-astri" "sst-astri+chec-s" 
            do
                FFLIST="${DD}_${ZE}/${DD}_${PP}_${A}_${ZE}_SSTOnly_${S}_${DL}.GRID.list"
                ./getRawFilesFromGRID-DIRAC.sh ${FFLIST} ${DD}/${P}/ 100 &> tmp_log/${P}_${A}_${S}.log &
            done
         # Prod3b SCT DL1
         elif [[ $DD = *"Prod3b"* ]] && [[ $DD = *"SCT_DL1"* ]]; then
             FLIST="${DD}/Prod3_Paranal_${PP}_${A}_${ZE}_${DL}.GRID.list"
             if [[ ! -e ${FLIST} ]]; then
               echo "$FLIST not found"
               exit
            fi
            echo "...found ${FLIST}"
            ./getRawFilesFromGRID-DIRAC.sh ${FLIST} ${DD}/${P}/ 100 &> tmp_log/${P}_${A}_${S}.log
         # all other productions
         else
            FLIST="${DD}/${DD}_${PP}_${A}_${ZE}_${DL}.GRID.list"
            # prod3b needs some special treatment
            if [[ ! -e ${FLIST} ]]; then
                echo "File list not found; trying prod3b naming ($FLIST); trying prod3b lists:"
                FLIST="${DD}_${ZE}_${DL}/Paranal_${PP}_${A}_${ZE}_${DL}.GRID.list"
                if [[ ! -e ${FLIST} ]]; then
                   echo "$FLIST not found"
                   exit
                fi
                echo "...found ${FLIST}"
            fi
            echo "Reading file list $FLIST"
            #./getRawFilesFromGRID-DIRAC.sh $FLIST ${DD}/${P}/ 100 ${SCT} &> tmp_log/${P}_${A}.log &
         fi
         sleep 10
     done
done
