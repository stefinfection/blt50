#!/bin/bash

module load bcftools

dirz=(\
"cumulative_0_10"
"cumulative_10_20"
"cumulative_20_30"
"cumulative_30_40"
"cumulative_40_50"
"cumulative_50_60"
"cumulative_60_70"
"cumulative_70_80"
"cumulative_80_90"
"cumulative_90_100"
)

files=(\
"0000" \
"0001" \
"0002" \
"0003" \
)

for d in ${dirz[@]};
do
    for f in ${files[@]};
    do
        bcftools stats "./${d}/${f}.vcf" > "./${d}/${f}.stats"
    done
done
