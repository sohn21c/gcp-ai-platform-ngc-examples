#!/usr/bin/env bash

mkdir -p /mnt/bert
mkdir -p /results
gcsfuse --only-dir bert \
        --implicit-dirs dlvm-dataset /mnt/bert

engine_dir=${1:-"/mnt/bert/trt_engine"}
checkpoint_dir=${2:-"/mnt/bert/checkpoint/bert_tf_v1_1_large_fp16_384_v2"}
squad_dir=${3:-"/mnt/bert/squad/v1.1"}
seq_length=${4:-"384"}
bert_model=${5:-"large"}

python3 builder.py -m $checkpoint_dir/model.ckpt-5474 -o $engine_dir/bert_${bert_model}_${seq_length}_int8.engine -c $checkpoint_dir -v $checkpoint_dir/vocab.txt --squad-json $squad_dir/train-v1.1.json -b 1 -s $seq_length --fp16 --int8 --strict -imh -iln

