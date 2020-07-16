FROM centos:7

ENV ENABLE_INIT_DAEMON true
ENV INIT_DAEMON_BASE_URI http://identifier/init-daemon
ENV INIT_DAEMON_STEP spark_master_init

ENV SPARK_VERSION=2.4.5
ENV HADOOP_VERSION=2.7

COPY wait-for-step.sh /
COPY execute-step.sh /
COPY finish-step.sh /
RUN yum install -y wget net-tools
RUN yum install -y gcc
RUN yum install -y make
RUN yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
RUN yum install -y java-1.8.0-openjdk-devel curl nss 
RUN export JAVA_HOME='/etc/alternatives/jre/'
RUN wget https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
RUN tar -xvzf Python-3.6.9.tgz
WORKDIR /Python-3.6.9/
RUN ./configure
RUN make
RUN make install
WORKDIR /
RUN rm -rf Python*

#RUN ln -s /lib64/ld-linux-x86-64.so.2 /lib/ld-linux-x86-64.so.
RUN chmod +x *.sh
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
RUN mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark
RUN rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz

#Give permission to execute scripts
RUN chmod +x /wait-for-step.sh && chmod +x /execute-step.sh && chmod +x /finish-step.sh
COPY spark-env.sh /spark/conf/
RUN chmod +x /spark/conf/spark-env.sh
RUN rm -rf /spark/python
# Fix the value of PYTHONHASHSEED
# Note: this is needed when you use Python 3.3 or greater
ENV PYTHONHASHSEED 1
RUN pip3 install pyspark==2.4.5
ENV PYSPARK_PYTHON /usr/local/bin/python3
ENV PYSPARK_DRIVER_PYTHON /usr/local/bin/python3
RUN ln -sf /usr/local/bin/python3 /usr/bin/python
RUN ln -sf /usr/local/bin/pip3 /usr/bin/pip 
