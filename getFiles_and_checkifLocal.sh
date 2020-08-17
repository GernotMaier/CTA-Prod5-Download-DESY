#!/bin/bash
# Script to prepare and monitor download 
#
#

if [ $# -lt 2 ]; then
echo "
Prepare and monitor prod5 download scripts

./getFiles_and_checkifLocal.sh <lists/check> <production>
"
exit
fi

if [[ ! -e ${2}.list ]]; then
   echo "Error: list of productions missing"
fi

FF=$(cat ${2}.list)

PDIR=`pwd`

mkdir -p ${2}

for F in $FF
do
    if [[ ${F} == *"gamma-diffuse"* ]]; then
        P="gamma_cone"
    elif [[ ${F} == *"gamma"* ]]; then
        P="gamma_onSource"
    elif [[ ${F} == *"proton"* ]]; then
        P="proton"
    elif [[ ${F} == *"electron"* ]]; then
        P="electron"
    else
        echo "unknown particle in $F"
        continue
    fi
    mkdir -p ${2}/${P}
    echo "READING $F"
    cd ${PDIR}/${2}
    if [[ ${1} == "lists" ]]; then
       cta-prod-dump-dataset $F
    elif [[ ${1} == "check" ]]; then
        cd ${PDIR}
       ./updateFileLists-DESY-SE.sh ${2} ${F} ${P}
    fi
    cd ${PDIR}
done

cd ${PDIR}

exit
