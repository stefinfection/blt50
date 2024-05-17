#!/bin/bash

module load bcftools

VCF_A=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/rufus_runs/1mb_smaht_merged_v2/hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz
VCF_B=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/rufus_runs/blt50_1mb_500x/SMHTCOLO829BLT50-X-X-M45-A001-dac-SMAARNRVZGBE-insilico500X_GRCh38.FINAL.no_inherited.no_svs.hd.vcf.gz
SOURCE_DIR=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/intersections/blt50_500x_vs_indel_adjusted_1mb/af_filtered_vcfs/

dirz=(\
"full_overlaps"
)

n=${#dirz[@]}
for (( i = 0; i < n; i++ ))
do
    curr_dir="${dirz[i]}"
    bcftools isec -c all -p $curr_dir $VCF_B $VCF_A
done
