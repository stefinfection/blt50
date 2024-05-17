#!/bin/bash

module load bcftools

T_UNIQ="0001.vcf"
OVERLAP="0002.vcf"

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

echo -e "range\tFull-Tumor-Unique\tOverlap\tPercentage" 

n=${#dirz[@]}
for (( i = 0; i < n; i++ ))
do
    curr_dir="${dirz[i]}"
    curr_range="${ranges[i]}"
    tumor=$(bcftools view -H "${curr_dir}/$T_UNIQ" | wc -l)
    overlap=$(bcftools view -H "${curr_dir}/$OVERLAP" | wc -l)
    sum=$($tumor + $overlap)
    perc=$(echo "scale=1; $overlap / $sum" | bc)
    perc="${perc}%"
    echo -e "$curr_range\t$tumor\t$overlap\t$perc"
done
