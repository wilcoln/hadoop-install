#!/usr/bin/env bash

echo "****************************"
echo "*   Hadoop Cluster Setup   *"
echo "****************************"

# Loading Variables
source conf/config.sh


# Adding hosts
# echo "1. Adding all hosts to /etc/hosts ..."

# echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'cat conf/hosts >> /etc/hosts'

# # Configuring SSH
# echo "2. Enabling SSH paswordless connection..."

# ssh-keygen -t rsa -f ~/.ssh/id_rsa
# HOSTNAMES=`awk '{print $2}' conf/hosts`

# for hostname in $HOSTNAMES
# do
# 	ssh-copy-id $hostname
# done

# # Installing Java 8
# echo "3. Installing Java..."

# echo $HADOOP_USER_PASSWORD | sudo -S add-apt-repository ppa:openjdk-r/ppa
# echo $HADOOP_USER_PASSWORD | sudo -S apt update
# echo $HADOOP_USER_PASSWORD | sudo -S apt install openjdk-8-jdk -y
# echo $HADOOP_USER_PASSWORD | sudo -S apt install openjdk-8-jdk-headless -y

# # Installing Hadoop 3.2.1
# echo "4. Installing Hadoop..."

# wget $HADOOP_ORIGIN
# echo $HADOOP_USER_PASSWORD | sudo -S tar -xzf hadoop-3.2.1.tar.gz -C $HADOOP_PARENT_DIR && rm -rf hadoop-3.2.1.tar.gz

# Configuring Hadoop
# echo "5. Configuring Hadoop..."

# echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_PARENT_DIR/hadoop-3.2.1/etc/hadoop-env.sh'
# echo $HADOOP_USER_PASSWORD | sudo -S cp conf/hadoop/* $HADOOP_PARENT_DIR/hadoop-3.2.1/etc/hadoop/

# # Updating .bashrc
# echo "6. Updating .bashrc..."

sudo -S bash -c 'source conf/config.sh && echo "JAVA_HOME=$JAVA_HOME" >> .bashrc'
sudo -S bash -c 'source conf/config.sh && echo "export JAVA_HOME" >> .bashrc'
sudo -S bash -c 'echo "PDSH_RCMD_TYPE=ssh" >> .bashrc'
sudo -S bash -c 'source conf/config.sh && echo "HADOOP_HOME=$HADOOP_PARENT_DIR/hadoop-3.2.1" >> .bashrc'
sudo -S bash -c "source conf/config.sh && echo PATH='$'PATH:'$'HADOOP_HOME/bin:'$'HADOOP_HOME/sbin >> .bashrc"



hdfs namenode -format
start-dfs.sh
start-yarn.sh