#!/usr/bin/env bash

mkdir bert_for_tensorflow_v6 && cd bert_for_tensorflow_v6
wget --content-disposition https://api.ngc.nvidia.com/v2/resources/nvidia/bert_for_tensorflow/versions/20.06.4/zip -O bert_for_tensorflow_20.06.4.zip
unzip bert_for_tensorflow_20.06.4.zip
cd ..

docker build -t gcr.io/k80-exploration/tf_bert_gcsfuse:latest .

docker push gcr.io/k80-exploration/tf_bert_gcsfuse:latest
