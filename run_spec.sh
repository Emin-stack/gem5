#/usr/bin/bash

run_dir_path=$(pwd)/spec2006/logs
# spec_path=/home/qimingchu/Applications/speccpu2006/speccpu2006-v1.0.1/benchspec/CPU2006/401.bzip2
name=bzip2_base.amd64-m64-gcc42-nn
exe_path=$spec_path/exe/bzip2_base.amd64-m64-gcc42-nn
input_path=$spec_path/data/ref/input
input_data=control

cp_count=$(find "$run_dir_path" -type d -name 'cpt*' | wc -l)
inst_position=$(find "$run_dir_path" -type d -name 'cpt.*' | sed 's/^.*cpt.//' | tail -n 1)

if [ "$cp_count" -eq 0 ]; then
	cp_count=1
fi

if [ -z "$1" ]; then
    r_cp=$cp_count
else
    r_cp="$1"
fi

last_log_name="spec_log_$((cp_count - 1)).txt"
log_name="spec_log_$((cp_count - 1)).txt"
echo -e "\e[34mWriting benchmark stdout to $log_name\e[0m"
echo -e "\e[91mrecover checkpoint is set to: $r_cp \e[0m"
echo -e "\e[34mstart from: $inst_position\e[0m"
sleep 2

build/X86/gem5.fast -d $run_dir_path configs/arch-training/spec/se.py \
-n 1 -c $exe_path \
-o $input_path/$input_data \
--benchmark_stdout $log_name --benchmark_stderr error_log.txt \
--mem-size=4048MB \
--cpu-type=TimingSimpleCPU \
--caches --l2cache --l3cache --l1d_size=16kB --l1i_size=16kB --l2_size=256kB --l3_size=2MB \
--warmup-insts=10000000 \
--checkpoint-dir $folder_path \
--checkpoint-at-end \
--work-begin-exit-count=1 \
--work-end-exit-count=1 \
--max-checkpoints=20 \
-r $r_cp
