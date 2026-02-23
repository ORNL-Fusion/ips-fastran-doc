#!/bin/bash -l

params=$1
results=$2
sim_id=$(printf "%05d" "${params##*.}")
sim_id_int=$(printf "%d" "${params##*.}")
echo $params $results $sim_id $sim_id_int

# user setup
SCAN_DIR=SCAN
SUMMARY_DIR=SUMMARY
CONFIG=fastran_scenario.config
PLATFORM=$MACHINE_CONFIG_SERIAL
COLLECT=collect.json
INPUT_MAP=input_map.json
OUTPUT_MAP=output_map.json

# generate ips configuration
dakota_ips_driver.py --config=$CONFIG --platform=$PLATFORM --scan_dir=$SCAN_DIR --summary_dir=$SUMMARY_DIR --params=$params --results=$results --input_map=$INPUT_MAP

# run ips.py
ips.py --config=$SCAN_DIR/run$sim_id.config --log=$SCAN_DIR/run$sim_id.log_ --platform=$PLATFORM 1> $SCAN_DIR/run$sim_id.out_ 2> $SCAN_DIR/run$sim_id.err_

# collect output files
collect.py  --rdir=$SCAN_DIR/run$sim_id --sdir=$SUMMARY_DIR --input=$COLLECT --single --shot=0 --time=$sim_id_int

# generate dakota result file
dakota_ips_result.py --rdir=$SUMMARY_DIR --shot=0 --time=$sim_id_int --output=$results --output_map=$OUTPUT_MAP
