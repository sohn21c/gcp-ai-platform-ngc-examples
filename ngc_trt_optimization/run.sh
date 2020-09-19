#!/usr/bin/env bash

mkdir -p /mnt/bert
mkdir -p /results
gcsfuse --only-dir bert \
        --implicit-dirs gtc-bert-demo /mnt/bert

BASE_DIR=/mnt/bert
ENGINE_DIR=$BASE_DIR/trt_engine
CHECKPOINT_DIR=$BASE_DIR/checkpoint/bert_tf_v1_1_large_fp16_384_v2
DATA_DIR=$BASE_DIR/squad/v1.1

seq_length=${1:-"384"}
bert_model=${2:-"large"}

python3 builder.py -m $CHECKPOINT_DIR/model.ckpt-5474 -o $ENGINE_DIR/bert_${bert_model}_${seq_length}_int8.engine -c $CHECKPOINT_DIR -v $CHECKPOINT_DIR/vocab.txt --squad-json $DATA_DIR/train-v1.1.json -b 1 -s $seq_length --fp16 --int8 --strict -imh -iln

