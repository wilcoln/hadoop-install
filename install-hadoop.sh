# This script asume all nodes of the cluster have a hadoop user
# which password is common to all of them
HADOOP_USER_PASSWORD="hadoop"

echo "****************************"
echo "*   Hadoop Cluster Setup   *"
echo "****************************"

# Adding hosts
echo "1. Adding all hosts to /etc/hosts ..."

echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'cat conf/hosts >> /etc/hosts'

# Configuring SSH
echo "2. Enabling SSH paswordless connection..."

ssh-keygen -t rsa -f ~/.ssh/id_rsa
HOSTNAMES=`awk '{print $2}' conf/hosts`

for hostname in $HOSTNAMES
do
	ssh-copy-id $hostname
done

# Installing Java 8
echo "3. Installing Java..."

echo $HADOOP_USER_PASSWORD | sudo -S add-apt-repository ppa:openjdk-r/ppa
echo $HADOOP_USER_PASSWORD | sudo -S apt update
echo $HADOOP_USER_PASSWORD | sudo -S apt install openjdk-8-jdk -y
echo $HADOOP_USER_PASSWORD | sudo -S apt install openjdk-8-jdk-headless -y

# Installing Hadoop 3.2.1
echo "4. Installing Hadoop..."

wget https://www-eu.apache.org/dist/hadoop/common/hadoop-3.2.1/hadoop-3.2.1.tar.gz
echo $HADOOP_USER_PASSWORD | sudo -S tar -xzf hadoop-3.2.1.tar.gz -C /usr/local/ && rm -rf hadoop-3.2.1.tar.gz

# Configuring Hadoop
echo "5. Configuring Hadoop..."

echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /usr/local/hadoop-3.2.1/etc/hadoop-env.sh'
echo $HADOOP_USER_PASSWORD | sudo -S cp conf/hadoop/* /usr/local/hadoop-3.2.1/etc/hadoop/

# Updating .bashrc
echo "6. Updating .bashrc..."

echo $HADOOP_USER_PASSWORD | sudo -S bash -c 'cat conf/bashrc >> ~/.bashrc'
