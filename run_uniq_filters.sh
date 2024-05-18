#!/bin/bash

SCRIPTS_DIR=$1
BLT50_TYPE=$2

VCF=0000.vcf
VCF_POSTFIX=".blt50_${BLT50_TYPE}_UNIQUE_hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf"

i=0
while [ "$(awk "BEGIN {print ($i <= 0.049)}")" -eq 1 ]; do
    max=$(awk "BEGIN {print ($i + 0.001)}")
    
    # if we've hit 5%, include everything
    if awk "BEGIN {exit !($max == 0.05)}"; then
        max="1"
    fi

    bash ${SCRIPTS_DIR}filter_af.sh $i $max $VCF $VCF_POSTFIX
    
    # Increment i by 0.001
    i=$max
done
