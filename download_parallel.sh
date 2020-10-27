#!/bin/bash
#
# simple script which allows to download
# all particle types simulatenously
#

# Prod5 NSB 1x
DD="Prod5_Paranal_AdvancedBaseline_NSB1x"
# Prod4b SST production
DD="Prod4b_Paranal"

ZE="20deg"
DL="DL0"

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
         else
            ./getRawFilesFromGRID-DIRAC.sh ${DD}/${DD}_${PP}_${A}_${ZE}_${DL}.GRID.list ${DD}/${P}/ 100 &> tmp_log/${P}_${A}.log &
         fi
         sleep 10
     done
done
