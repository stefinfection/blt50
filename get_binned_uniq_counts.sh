#!/bin/bash

ISEC_DIR_PATH=$1
SCRIPTS_PATH=$2
BLT50_TYPE=$3
MIN=$4
MAX=$5
STEP=$6
PARENT_DIR=$7

SOURCE_DIR="${ISEC_DIR_PATH}full_overlaps/"
COUNTS_OUT="binned_blt50_${BLT50_TYPE}_uniq_counts.txt"

cd $SOURCE_DIR

# Filter variants unique to the BLT50 sample in 0.001% increments
bash ${SCRIPTS_PATH}run_uniq_filters.sh $SCRIPTS_PATH $BLT50_TYPE $MIN $MAX $STEP

bash ${SCRIPTS_PATH}compose_uniq_counts.sh $BLT50_TYPE $COUNTS_OUT $MIN $MAX $STEP $PARENT_DIR
