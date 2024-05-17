#!/bin/bash

module load bcftools

BLT50_VCF=$1
FULL_TUMOR_VCF=$2
OUT_FILE="full_overlaps/full_isec_counts.txt"

# Perform intersections
dirz=(\
"full_overlaps"
)

n=${#dirz[@]}
for (( i = 0; i < n; i++ ))
do
    curr_dir="${dirz[i]}"
    mkdir $curr_dir
    bcftools isec -c all -p $curr_dir $BLT50_VCF $FULL_TUMOR_VCF
done

# Perform stats on intersections
files=(\
"0000" \
"0001" \
"0002" \
)

echo -e "BLT50-Unique\tFull-Tumor-Unique\tOverlap" >> $OUT_FILE

for d in ${dirz[@]};
do
    line=""
    for f in ${files[@]};
    do
        count=$(bcftools view -H "${d}/${f}.vcf" | wc -l)
        line="$line$count\t"
    done
    echo -e $line >> $OUT_FILE
done
