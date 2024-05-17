#!/bin/bash

TUMOR_VCF=$1
DEST_DIR=$2
SCRIPTS_DIR=$3

cd $DEST_DIR

bash ${SCRIPTS_DIR}filter_af.sh 0 0.1 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.1 0.2 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.2 0.3 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.3 0.4 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.4 0.5 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.5 0.6 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.6 0.7 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.7 0.8 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.8 0.9 $TUMOR_VCF
bash ${SCRIPTS_DIR}filter_af.sh 0.9 1 $TUMOR_VCF
