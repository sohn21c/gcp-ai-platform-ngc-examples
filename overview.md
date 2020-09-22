# Description
This repo contains a set of code and scripts that performs the followings on Google Cloud AI Platform with assets from NGC:  

- Finetuning BERT model on SQuAD dataset
- Optimizing finetuned BERT model with TensorRT 
- Deploying BERT TensorRT engine with Triton Inference Server  

Each folder, named after each tasks, contains an individual set of scripts and code, along with the readme that shows the general steps to run them. The scripts, as-is, are **NOT READY TO USE** as the scripts may contain commands with user-specific information such as Google Cloud Storage bucket name, or user's Google Cloud project name.  

Reader may refer to the **[demo recording]()** that accompanies this repo, to learn the details.  

# Usage Instruction
Jupyter notebook, `ngc_triton_bert_deployment/bert_on_caip.ipynb`, is the best place to start, as it contains the commands to run for each task. However, it is 
strongly recommended to watch **[demo recording]()** created to walk through step-by-step on what's shown in the notebook, to understand the details.

For each tasks, refer to individual readme, included in the directory to learn more about the task and its detail.

# End User License Agreements
Refer to the following NVIDIA End User License Agreements, included in **LICENSE** file.
