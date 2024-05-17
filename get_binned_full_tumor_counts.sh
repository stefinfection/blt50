#!/bin/bash

module load bcftools

# e.g. /scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/intersections/blt50_500x_vs_indel_adjusted_1mb/
ISEC_DIR_PATH=$1
FULL_TUMOR_VCF=$2
BLT50_VCF=$3 
COUNTS_OUT=$4
SCRIPTS_PATH=$5
SOURCE_DIR="${ISEC_DIR_PATH}af_filtered_full_tumor_vcfs/"

# Filter full tumor vcf for intersections
mkdir $SOURCE_DIR
bash ${SCRIPTS_PATH}run_filters.sh $FULL_TUMOR_VCF $SOURCE_DIR $SCRIPTS_PATH
cd $ISEC_DIR_PATH

# Perform intersections
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
    mkdir ${ISEC_DIR_PATH}$curr_dir
    curr_file="${files[i]}"
    bcftools isec -c all -p $curr_dir $BLT50_VCF ${SOURCE_DIR}$curr_file
done

# Write out counts
T_UNIQ="0001.vcf"
OVERLAP="0002.vcf"

ranges=(
"0-10%"
"10-20%"
"20-30%"
"30-40%"
"40-50%"
"50-60%"
"60-70%"
"70-80%"
"80-90%"
"90-100%"
)

echo -e "range\tFull-Tumor-Unique\tOverlap\tPercentage" > $COUNTS_OUT

n=${#dirz[@]}
for (( i = 0; i < n; i++ ))
do
    curr_dir="${dirz[i]}"
    curr_range="${ranges[i]}"
    tumor=$(bcftools view -H "${curr_dir}/$T_UNIQ" | wc -l)
    overlap=$(bcftools view -H "${curr_dir}/$OVERLAP" | wc -l)
    sum=$(($tumor + $overlap))
    perc=$(awk "BEGIN {printf \"%.1f\", ($overlap / $sum) * 100}")
    perc="${perc}%"
    echo -e "$curr_range\t$tumor\t$overlap\t$perc" >> $COUNTS_OUT
done
