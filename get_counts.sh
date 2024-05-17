# This script performs intersections and stats to analyze specificity and sensitivity of the full indel-adjusted COLO829 tumor vs normal call set vs a given BLT50 call set. The final outputs are txt files with counts that can be ported into R double_bar_blt50.qmd. This script needs to be performed within the desired output directory.
# Stephanie Georges May2024 for Marth Lab


BLT50_VCF=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/rufus_runs/blt50_1mb_500x/SMHTCOLO829BLT50-X-X-M45-A001-dac-SMAARNRVZGBE-insilico500X_GRCh38.FINAL.no_inherited.no_svs.hd.vcf.gz
FULL_COUNTS_OUTPUT="binned_intersect_counts.txt"
FULL_TUMOR_VCF=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/rufus_runs/1mb_smaht_merged_v2/hd_med.COLO829.Ill.1mb.final.no_inherited.no_svs.vcf.gz
ISEC_DIR_PATH=$(pwd)/
SCRIPTS_PATH=/scratch/ucgd/lustre-labs/marth/scratch/u0746015/COLO829/intersections/scripts/

# Perform full call set intersections
bash ${SCRIPTS_PATH}intersect_full_set.sh $BLT50_VCF $FULL_TUMOR_VCF
echo "Generated full intersection in full_overlaps"

# Perform binned call set intersections. These are the full tumor vcf filtered into 10% bins from 0-100% AF, and intersected with the unfiltered BLT50 vcf.
bash ${SCRIPTS_PATH}get_binned_full_tumor_counts.sh $ISEC_DIR_PATH $FULL_TUMOR_VCF $BLT50_VCF $FULL_COUNTS_OUTPUT $SCRIPTS_PATH
echo "Generated binned_intersect_counts.txt"

# Get counts of binned unique BLT50 variants. These are variants not found in the full tumor run, stratified into 0.1% bins.
 
