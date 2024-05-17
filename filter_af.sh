#!/bin/bash

MIN=$1
MAX=$2
TUMOR_VCF=$3
DEST_DIR=$4
OUT_VCF="af_${MIN}_${MAX}.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf"

touch $OUT_VCF

bcftools filter -i "((INFO/HD_MED)/(FMT/DP[0]))<=$MAX && ((INFO/HD_MED)/(FMT/DP[0]))>=$MIN" $TUMOR_VCF -o $OUT_VCF -Ov
bgzip $OUT_VCF
bcftools index -t "${OUT_VCF}.gz"
