#!/bin/bash

SCRIPTS_DIR=$1
BLT50_TYPE=$2
MIN=$3
MAX=$4
STEP=$5
OVERLAP_SOURCE_DIR=$6

OVERLAP_VCF="${OVERLAP_SOURCE_DIR}0002.vcf"
VCF_POSTFIX=".blt50_${BLT50_TYPE}_UNIQUE_hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf"
TUMOR_ONLY_VCF="${OVERLAP_SOURCE_DIR}0001.vcf"

mkdir overlap_bins
cd overlap_bins
i=$MIN
while [ "$(awk "BEGIN {print ($i <= $MAX)}")" -eq 1 ]; do
    max=$(awk "BEGIN {print ($i + $STEP)}")
    
    bash ${SCRIPTS_DIR}filter_af.sh $i $max $OVERLAP_VCF $VCF_POSTFIX
    
    # Increment i by 0.001
    i=$max
done

cd ..
mkdir tumor_only_bins
cd tumor_only_bins
i=$MIN
while [ "$(awk "BEGIN {print ($i <= $MAX)}")" -eq 1 ]; do
    max=$(awk "BEGIN {print ($i + $STEP)}")
        
    bash ${SCRIPTS_DIR}filter_af.sh $i $max $TUMOR_ONLY_VCF $VCF_POSTFIX
        
    # Increment i by 0.001
    i=$max
done

cd ..
