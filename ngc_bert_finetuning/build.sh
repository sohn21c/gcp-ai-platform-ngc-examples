#!/usr/bin/env bash

mkdir bert_for_tensorflow && cd bert_for_tensorflow
wget --content-disposition https://api.ngc.nvidia.com/v2/resources/nvidia/bert_for_tensorflow/versions/20.06.7/zip -O bert_for_tensorflow_20.06.7.zip
unzip bert_for_tensorflow_20.06.7.zip
cd ..

docker build -t gcr.io/k80-exploration/gtc_demo_bert:latest .

docker push gcr.io/k80-exploration/gtc_demo_bert:latest
