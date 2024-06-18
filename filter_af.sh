#!/bin/bash

MIN=$1
MAX=$2
TUMOR_VCF=$3
OUT_VCF_POSTFIX=$4

OUT_VCF="af_${MIN}_${MAX}${OUT_VCF_POSTFIX}"

touch $OUT_VCF

if [[ "$MAX" == "inf" ]]; then
    bcftools filter -i "((INFO/HD_MED)/(FMT/DP[0]))>=$MIN" $TUMOR_VCF -o $OUT_VCF -Ov
else
    bcftools filter -i "((INFO/HD_MED)/(FMT/DP[0]))<=$MAX && ((INFO/HD_MED)/(FMT/DP[0]))>=$MIN" $TUMOR_VCF -o $OUT_VCF -Ov
fi
bgzip $OUT_VCF
bcftools index -t "${OUT_VCF}.gz"
