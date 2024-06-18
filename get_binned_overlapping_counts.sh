#!/bin/bash

ISEC_DIR_PATH=$1
SCRIPTS_PATH=$2
BLT50_TYPE=$3
MIN=$4
MAX=$5
STEP=$6

SOURCE_DIR="${ISEC_DIR_PATH}full_overlaps/"
OUT_DIR="${ISEC_DIR_PATH}full_tumor_shared_overlaps/"
COUNTS_OUT="binned_blt50_${BLT50_TYPE}_full_tumor_overlapping_counts.txt"

mkdir -p $OUT_DIR
cd $OUT_DIR

# Filter variants unique to the BLT50 sample in 0.001% increments
bash ${SCRIPTS_PATH}run_overlapping_filters.sh $SCRIPTS_PATH $BLT50_TYPE $MIN $MAX $STEP $SOURCE_DIR

bash ${SCRIPTS_PATH}compose_overlapping_counts.sh $BLT50_TYPE $COUNTS_OUT $MIN $MAX $STEP $SOURCE_DIR
