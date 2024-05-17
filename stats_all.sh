#!/bin/bash

module load bcftools

dirz=(\
"full_overlaps"
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
