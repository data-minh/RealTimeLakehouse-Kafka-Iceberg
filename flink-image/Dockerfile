# Use Flink image as base
FROM flink:1.16.1-scala_2.12

# Update the system, add PPA, and install Python 3.9 with distutils
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update && apt-get install -y \
    python3.9 python3.9-distutils curl \
    && curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set Python 3.9 as the default
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1

# Create symbolic link for Python
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN pip install --no-cache-dir "apache-flink==1.16.1" "confluent-kafka"

###############################################
## Download Necessary Jars to Flink Class Path
###############################################

## Iceberg Flink Library
RUN curl -L https://repo1.maven.org/maven2/org/apache/iceberg/iceberg-flink-runtime-1.16/1.3.1/iceberg-flink-runtime-1.16-1.3.1.jar -o /opt/flink/lib/iceberg-flink-runtime-1.16-1.3.1.jar

## Hive Flink Library
RUN curl -L https://repo1.maven.org/maven2/org/apache/flink/flink-sql-connector-hive-2.3.9_2.12/1.16.1/flink-sql-connector-hive-2.3.9_2.12-1.16.1.jar -o /opt/flink/lib/flink-sql-connector-hive-2.3.9_2.12-1.16.1.jar

## Hadoop Common Classes
RUN curl -L https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/2.8.3/hadoop-common-2.8.3.jar -o /opt/flink/lib/hadoop-common-2.8.3.jar

## Hadoop AWS Classes
RUN curl -L https://repo.maven.apache.org/maven2/org/apache/flink/flink-shaded-hadoop-2-uber/2.8.3-10.0/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar -o /opt/flink/lib/flink-shaded-hadoop-2-uber-2.8.3-10.0.jar 

## AWS Bundled Classes
RUN curl -L https://repo1.maven.org/maven2/software/amazon/awssdk/bundle/2.20.18/bundle-2.20.18.jar -o /opt/flink/lib/bundle-2.20.18.jar

# Kafka SQL Connector
RUN curl -L https://repo.maven.apache.org/maven2/org/apache/flink/flink-sql-connector-kafka/1.16.1/flink-sql-connector-kafka-1.16.1.jar -o /opt/flink/lib/flink-sql-connector-kafka-1.16.1.jar

###############################################
## Start Flink
###############################################
CMD ["./bin/start-cluster.sh"]

