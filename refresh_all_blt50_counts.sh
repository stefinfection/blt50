#!/bin/bash

PARENT_DIR=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/intersections/

dirz=(
    "100x"
    "200x"
    "300x"
    "400x"
    "500x"
    "bcm"
    "broad"
    "nygc"
    "uw"
    "washu"
)

# remove cumulative files
rm "${PARENT_DIR}all_blt50_overlapping_counts.txt"
rm "${PARENT_DIR}all_blt50_uniq_counts.txt"

for dir in "${dirz[@]}"; do
    curr_dir="blt50_${dir}_vs_indel_adjusted_1mb/"
    curr_file="/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/rufus_runs/blt50_1mb_${dir}/*no_inherited.no_svs.hdmed.vcf.gz"
    cd ${PARENT_DIR}${curr_dir}
    rm -rf ${PARENT_DIR}${curr_dir}*
    bash ${PARENT_DIR}scripts/get_counts.sh $dir $curr_file
done
