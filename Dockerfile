FROM alpine/k8s:1.14.9

RUN apk update && \
    apk add python3 \
    py3-pip \
    iputils \
    net-tools \
    curl \
    nmap-ncat \
    nmap \
    nmap-scripts \
    bind-tools \
    tcpdump \
    tcptraceroute \
    jq \
    bash \
    openssh \
    tmux \
    htop \
    git

ENV HOME=/root
RUN mkdir -p ${HOME}/bin
RUN echo -e "PS1='\u@\h: \w # '\n\
    PATH=${PATH}:${HOME}/bin\n\
    alias python=python3\n\
    alias k=kubectl\n"\
    >> /root/.bashrc

ENV http_test_dir=${HOME}/bin/http-test
RUN echo -e "python3 -m http.server ${1}" > ${http_test_dir} && \
    chmod +x ${http_test_dir}

ENTRYPOINT ["/bin/bash","-l","-c"]
CMD ["bash"]