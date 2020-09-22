### AI Platform TF BERT TensorRT Optimization on GPU Guide

* Task summary:
    Optimize fine-tuned BERT QA model with TensorRT using Google Cloud AI Platform Training service.  
    
* User needs to push the docker container to GCP container registry. Here we used : `gcr.io/k80-exploration/gtc_demo_trt_bert:latest`, please modify `build.sh` accordingly to point to your own GCP project  
* User needs to modify `run.sh` to provide correct GCS path. Here we used: `gtc-bert-demo` in GCS to locate necessary assets

* To run this example, execute:
```
export IMAGE_URI=gcr.io/k80-exploration/gtc_demo_trt_bert:latest
export REGION=us-central1
export JOB_NAME=bert_optimization_job_$(date +%Y%m%d_%H%M%S)

gcloud ai-platform jobs submit training $JOB_NAME \
    --master-image-uri $IMAGE_URI \
    --region $REGION \
    --master-accelerator count=1,type=nvidia-tesla-t4 \
    --master-machine-type n1-highmem-8 \
    --scale-tier custom
```
* For more information, please refer to **GTC 2020 Building NLP Solutions with NGC Models and Containers on Google Cloud AI Platform [A21324]**