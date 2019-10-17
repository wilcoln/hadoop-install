#!/usr/bin/env bash

echo "****************************"
echo "*   Hadoop Cluster Setup   *"
echo "****************************\n"

# 0. Loading Variables
source conf/config.sh

# 1. Adding hosts
echo ">>>> 1. Adding all hosts to /etc/hosts ..."

echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'cat conf/hosts >> /etc/hosts'

echo "<<<< done. \n"

# 2. Configuring SSH
echo ">>>> 2. Enabling SSH paswordless connection... <<<<"

ssh-keygen -t rsa -f ~/.ssh/id_rsa # generate ssh key for the node
HOSTNAMES=`awk '{print $2}' conf/hosts` # get all hostnames in conf/hosts file

for hostname in $HOSTNAMES
do
	ssh-copy-id $hostname # copy node ssh public key to all nodes in the cluster
done

echo "<<<< done. \n"

# Installing Java 8
echo ">>>> 3. Installing Java... <<<<"

echo $HADOOP_USER_PASSWORD | sudo -S add-apt-repository ppa:openjdk-r/ppa
echo $HADOOP_USER_PASSWORD | sudo -S apt update
echo $HADOOP_USER_PASSWORD | sudo -S apt install openjdk-8-jdk -y
echo $HADOOP_USER_PASSWORD | sudo -S apt install openjdk-8-jdk-headless -y

# Installing Hadoop 3.2.1
echo ">>>> 4. Installing Hadoop... <<<<"

wget $HADOOP_ORIGIN
echo $HADOOP_USER_PASSWORD | sudo -S tar -xzf hadoop-3.2.1.tar.gz -C $HADOOP_PARENT_DIR && rm -rf hadoop-3.2.1.tar.gz

echo "<<<< done. \n"

# Configuring Hadoop
echo ">>>> 5. Configuring Hadoop... <<<<"

echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_PARENT_DIR/hadoop-3.2.1/etc/hadoop-env.sh'
echo $HADOOP_USER_PASSWORD | sudo -S cp conf/hadoop/* $HADOOP_PARENT_DIR/hadoop-3.2.1/etc/hadoop/

echo "<<<< done. \n"

# Updating .bashrc
echo ">>>> 6. Updating .bashrc... <<<<"

## Add and export Java
echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "JAVA_HOME=$JAVA_HOME" >> ~/.bashrc'
echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "export JAVA_HOME" >> ~/.bashrc'
## Set PSDSH type to ssh
echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'echo "PDSH_RCMD_TYPE=ssh" >> ~/.bashrc'
## set Hadoop home directory
echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "HADOOP_HOME=$HADOOP_PARENT_DIR/hadoop-3.2.1" >> ~/.bashrc'
## Update and export PATH
echo $HADOOP_USER_PASSWORD | sudo -S bash -c "source conf/config.sh && echo PATH='$'PATH:'$'HADOOP_HOME/bin:'$'HADOOP_HOME/sbin >> ~/.bashrc"
echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'source conf/config.sh && echo "export PATH" >> ~/.bashrc'

echo "<<<< done. \n"
