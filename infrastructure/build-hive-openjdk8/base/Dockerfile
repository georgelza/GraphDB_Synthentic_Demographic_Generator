ARG REPO_NAME="georgelza"

FROM ${REPO_NAME}/ubuntu-24.04-openjdk8:1.0.0

RUN echo "--> set environment variable"
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-arm64
ENV HADOOP_VERSION=3.3.5
ENV HADOOP_HOME=/opt/hadoop
ENV HADOOP_CONF_DIR=$HADOOP_HOME/conf
ENV MULTIHOMED_NETWORK=1
ENV HADOOP_HEAPSIZE=1024
ENV PATH=$HADOOP_HOME/bin/:$PATH
ENV USER=root

USER root
WORKDIR /tmp/
RUN echo "--> Copy Source Binaries"
COPY stage/hadoop-$HADOOP_VERSION-aarch64.tar.gz /tmp

RUN echo "--> install Apache Hadoop 3.3.5" && \
    tar -xzvf /tmp/hadoop-$HADOOP_VERSION-aarch64.tar.gz && \
    mv /tmp/hadoop-$HADOOP_VERSION $HADOOP_HOME && \
    rm -rf /tmp/*

RUN echo "--> create symbolic link for hadoop" && \
    ln -s $HADOOP_HOME/etc/hadoop /etc/hadoop

RUN echo "--> make Apache Hadoop directories" && \
    mkdir -p $HADOOP_HOME/logs && \
    mkdir -p $HADOOP_HOME/conf && \
    mkdir -p /hadoop-data

WORKDIR $HADOOP_HOME

ADD bin/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]