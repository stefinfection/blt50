#!/bin/bash

module load bcftools

VCF="0000.vcf"
OUT_VCF="af_filtered.0000.vcf"

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

mins=(
0
0.002
0.004
0.006
0.008
0.01
0.012
0.014
0.016
0.018
)

maxs=(
0.002
0.004
0.006
0.008
0.01
0.012
0.014
0.016
0.018
0.02
)

n=${#dirz[@]}
for (( i = 0; i < n; i++ ))
do
    curr_dir="${dirz[i]}"
    curr_max="${maxs[i]}"
    curr_min="${mins[i]}"
    bcftools filter -i "((INFO/HD_MED)/(FMT/DP[0]))<=$curr_max && ((INFO/HD_MED)/(FMT/DP[0]))>=$curr_min" "${curr_dir}/$VCF" -o "${curr_dir}/$OUT_VCF" -Ov
done
