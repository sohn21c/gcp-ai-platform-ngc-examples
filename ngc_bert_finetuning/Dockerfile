FROM nvcr.io/nvidia/tensorflow:20.03-tf1-py3

RUN apt-get update && apt-get install -y pbzip2 pv bzip2 libcurl4 curl
RUN pip install --upgrade pip
RUN pip install toposort networkx pytest nltk tqdm html2text progressbar
RUN pip --no-cache-dir --no-cache install git+https://github.com/NVIDIA/dllogger

WORKDIR /workspace
RUN git clone https://github.com/openai/gradient-checkpointing.git
RUN git clone https://github.com/attardi/wikiextractor.git
RUN git clone https://github.com/soskek/bookcorpus.git
RUN git clone https://github.com/titipata/pubmed_parser

RUN pip3 install /workspace/pubmed_parser

WORKDIR /workspace/bert
COPY bert_for_tensorflow .

ENV PYTHONPATH /workspace/bert
ENV BERT_PREP_WORKING_DIR /workspace/bert/data
ENV PATH //workspace/install/bin:${PATH}
ENV LD_LIBRARY_PATH /workspace/install/lib:${LD_LIBRARY_PATH}

RUN apt-get update && apt-get install -y lsb-core && export GCSFUSE_REPO=gcsfuse-`lsb_release -c -s` && \
    echo "deb http://packages.cloud.google.com/apt $GCSFUSE_REPO main" | tee /etc/apt/sources.list.d/gcsfuse.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y gcsfuse && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    apt-get install -y apt-transport-https ca-certificates && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt-get update && apt-get install -y google-cloud-sdk && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 30

WORKDIR /workspace/bert

ADD run.sh /workspace/bert

ENTRYPOINT ["bash", "run.sh"]

