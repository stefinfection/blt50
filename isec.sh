#!/bin/bash

module load bcftools

STATIC_VCF=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/rufus_runs/blt50_1mb_500x/SMHTCOLO829BLT50-X-X-M45-A001-dac-SMAARNRVZGBE-insilico500X_GRCh38.FINAL.no_inherited.no_svs.hd.vcf.gz
SOURCE_DIR=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/intersections/blt50_500x_vs_indel_adjusted_1mb/af_filtered_vcfs/

dirz=(\
"binned_0_10"
"binned_10_20"
"binned_20_30"
"binned_30_40"
"binned_40_50"
"binned_50_60"
"binned_60_70"
"binned_70_80"
"binned_80_90"
"binned_90_100"
)

files=(
"af_0_0.1.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.1_0.2.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.2_0.3.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.3_0.4.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.4_0.5.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.5_0.6.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.6_0.7.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.7_0.8.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.8_0.9.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
"af_0.9_1.hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"
)

n=${#dirz[@]}
for (( i = 0; i < n; i++ ))
do
    curr_dir="${dirz[i]}"
    curr_file="${files[i]}"
    bcftools isec -c all -p $curr_dir $STATIC_VCF ${SOURCE_DIR}$curr_file
done
