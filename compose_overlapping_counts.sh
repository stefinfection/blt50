#!/bin/bash

BLT50_TYPE=$1
OUT_FILE=$2
MIN=$3
MAX=$4
STEP=$5

VCF_POSTFIX=".blt50_${BLT50_TYPE}_UNIQUE_hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz"

echo -e "file\tmin\tmax\tcount\tlabel" > $OUT_FILE

i=$MIN
# bash can't do fp arithmetic in for loops...
while [ "$(awk "BEGIN {print ($i <= $MAX)}")" -eq 1 ]; do
    min=$i
    max=$(awk "BEGIN {print ($i + $STEP)}")

    curr_vcf="af_${min}_${max}${VCF_POSTFIX}"
    count=$(bcftools view -H $curr_vcf | wc -l)
    min_perc=$(awk "BEGIN {print ($min * 100)}")
    max_perc=$(awk "BEGIN {print ($max * 100)}")
    label="${min_perc}-${max_perc}%"
    echo -e "$curr_vcf\t$min\t$max\t$count\t$label" >> $OUT_FILE
   
    # increment loop
    i=$max
done
