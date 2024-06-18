#!/bin/bash

SCRIPTS_DIR=$1
BLT50_TYPE=$2
MIN=$3
MAX=$4
STEP=$5


VCF=0000.vcf
VCF_POSTFIX=".blt50_${BLT50_TYPE}_UNIQUE_hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf"

i=$MIN
max=0
while [ "$(awk "BEGIN {print ($i < $MAX)}")" -eq 1 ] && [ "$max" != "inf" ]; do
    max=$(awk "BEGIN {print ($i + $STEP)}")
    
    # if we've hit max, include everything
    #if awk "BEGIN {exit !($max == $MAX)}"; then
    #    max="inf"
    #fi
    bash ${SCRIPTS_DIR}filter_af.sh $i $max $VCF $VCF_POSTFIX
    
    # Increment
    i=$max
done

# Also generate 5-500% and 5-10% for analysis purposes
#bash ${SCRIPTS_DIR}filter_af.sh 0.05 5 $VCF $VCF_POSTFIX
#bash ${SCRIPTS_DIR}filter_af.sh 0.05 0.10 $VCF $VCF_POSTFIX
