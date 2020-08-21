#!/bin/bash
#
# simple script which allows to download
# all particle types simulatenously
#

DD="Prod5_Paranal_AdvancedBaseline_NSB1x"
DL="DL0"
ZE="20deg"

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
         ./getRawFilesFromGRID-DIRAC.sh ${DD}/${DD}_${PP}_${A}_${ZE}_${DL}.GRID.list ${DD}/${P}/ 100 &> tmp_log/${P}_${A}.log &
         sleep 10
     done
done
