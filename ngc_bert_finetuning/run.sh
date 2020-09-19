#!/usr/bin/env bash

mkdir -p /mnt/bert
mkdir -p /results
gcsfuse --only-dir bert \
        --implicit-dirs gtc-bert-demo /mnt/bert

batch_size=${1:-"4"}
learning_rate=${2:-"5e-6"}
precision=${3:-"fp16"}
use_xla=${4:-"true"}
num_gpu=${5:-"8"}
seq_length=${6:-"384"}
doc_stride=${7:-"128"}
bert_model=${8:-"large"}
squad_version=${9:-"1.1"}
epochs=${10:-"2.0"}

use_fp16=""
if [ "$precision" = "fp16" ] ; then
    echo "fp16 activated!"
    use_fp16="--amp"
else
    echo "fp32/tf32 activated!"
    use_fp16="--noamp"
fi

if [ "$squad_version" = "1.1" ] ; then
    version_2_with_negative="False"
else
    version_2_with_negative="True"
fi

if [ "$use_xla" = "true" ] ; then
    use_xla_tag="--use_xla"
    echo "XLA activated"
else
    use_xla_tag="--nouse_xla"
fi

if [ $num_gpu -gt 1 ] ; then
    mpi_command="mpirun -np $num_gpu -H localhost:$num_gpu \
    --allow-run-as-root -bind-to none -map-by slot \
    -x NCCL_DEBUG=INFO \
    -x LD_LIBRARY_PATH \
    -x PATH -mca pml ob1 -mca btl ^openib"
else
    mpi_command=""
fi

BASE_DIR=/mnt/bert
BERT_DIR=$BASE_DIR/checkpoint/bert_tf_pretraining_lamb_16n_v1
DATA_DIR=$BASE_DIR/squad/v1.1
RESULT_DIR=$BASE_DIR/output
printf "Saving checkpoints to %s\n" "$RESULT_DIR"
export CUDA_VISIBLE_DEVICES=0,1,3,2,7,6,4,5

$mpi_command python run_squad.py \
        --vocab_file=$BERT_DIR/vocab.txt \
        --bert_config_file=$BERT_DIR/bert_config.json \
        --init_checkpoint=$BERT_DIR/model.ckpt-1564 \
        --output_dir=$RESULT_DIR \
        --train_batch_size=$batch_size \
        --do_predict=True \
        --predict_file=$DATA_DIR/dev-v1.1.json \
        --eval_script=$DATA_DIR/evaluate-v1.1.py \
        --do_train=True \
        --train_file=$DATA_DIR/train-v1.1.json \
        --learning_rate=$learning_rate \
        --num_train_epochs=$epochs \
        --max_seq_length=$seq_length \
        --doc_stride=$doc_stride \
        --save_checkpoints_steps 1000 \
        --horovod "$use_fp16" \
        $use_xla_tag \
        --version_2_with_negative=${version_2_with_negative}
