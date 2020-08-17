#!/bin/bash
#
# copy file list into the analysis directories

if [ $# -lt 2 ]; then
echo "
copy file lists into the analysis directory


./copy_file_lists.sh <production> <target directory>
"
exit
fi

mkdir -p ${2}

for P in gamma_onSource gamma_cone proton electron
do
   for D in North South
   do
      if [[ ${P} == "gamma_onSource" ]]; then
         PP="gamma"
      elif [[ ${P} == "gamma_cone" ]]; then
         PP="gamma-diffuse"
      else
         PP=${P}
      fi
      if [[ ${D} == "North" ]]; then
         DD="0deg"
      else
         DD="180deg"
      fi
      if [[ -e ${1}/${1}_${PP}_${D}_20deg_DL0.local.list ]]; then
          OFILE=${P}_${DD}.list
          cp -v -f ${1}/${1}_${PP}_${D}_20deg_DL0.local.list ${2}/${OFILE}
      fi
    done
    rm -f ${2}/${P}.list
    touch ${2}/${P}.list
    cat ${2}/${P}_*.list >> ${2}/${P}.list
done

