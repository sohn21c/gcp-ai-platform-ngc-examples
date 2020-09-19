### AI Platform TF BERT Fine-tuning on GPU Guide

* Download the squad v1.1 dataset, in this example,
 we download to a GCS location `gs://gtc-bert-demo/bert/squad`, 
 modify run.sh accordingly
* User needs to push the docker images to GCP container registry, 
here we used: `gcr.io/k80-exploration/gtc_demo_bert:latest`, 
please modify build.sh accordingly to point to your own GCP projects. 
* To run this example, execute:
```
#upload to gs://gtc-bert-demo/bert/checkpoint
wget --content-disposition https://api.ngc.nvidia.com/v2/models/nvidia/bert_tf_ckpt_large_pretraining_amp_lamb/versions/19.03.0/zip -O bert_tf_ckpt_large_pretraining_amp_lamb_19.03.0.zip

export MODEL_DIR=example_model_$(date +%Y%m%d_%H%M%S)
export IMAGE_URI=gcr.io/k80-exploration/gtc_demo_bert:latest
export REGION=us-central1
export JOB_NAME=bert_job_$(date +%Y%m%d_%H%M%S)

gcloud ai-platform jobs submit training $JOB_NAME \
    --master-image-uri $IMAGE_URI \
    --region $REGION \
    --master-accelerator count=8,type=nvidia-tesla-v100 \
    --master-machine-type n1-highmem-96 \
    --scale-tier custom
```
* For more information, please refer to **GTC 2020 Building NLP Solutions with NGC Models and Containers on Google Cloud AI Platform [A21324]**