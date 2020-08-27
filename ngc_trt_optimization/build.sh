#!/usr/bin/env bash

git clone https://github.com/NVIDIA/TensorRT.git

# Build the docker image using the provided Docker file
docker build -t gcr.io/k80-exploration/bert_trt_gcsfuse:latest .

docker push gcr.io/k80-exploration/bert_trt_gcsfuse:latest
