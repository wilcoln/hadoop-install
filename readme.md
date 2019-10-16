# Environment settings
1. Get master ip@
2. Get slaves ip@
3. For all the machines of the cluster add all the other's hostname in the /etc/hosts
    e.g
    192.168.1.2 master
    192.168.1.3 slave1
    192.168.1.4 slave2

4. Enable passwordless ssh connection all over the cluster
    (create a hadoop same user on all hosts)
    Log into the slave machine using this command:
    ssh -l <username> <slave machine>

## Copying
    - In the master
    ssh-keygen
    scp ~/.ssh/id_rsa.pub hadoop@slave1: ~/id.master 
    scp ~/.ssh/id_rsa.pub hadoop@slave2:~/id.master

    - In slave 1
    ssh-keygen
    scp ~/.ssh/id_rsa.pub hadoop@master: ~/id.slave1
    scp ~/.ssh/id_rsa.pub hadoop@slave2:~/id.slave1

    - In slave 2
    ssh-keygen
    scp ~/.ssh/id_rsa.pub hadoop@master: ~/id.slave2
    scp ~/.ssh/id_rsa.pub hadoop@slave1:~/id.slave2

## Registering

    - In the master
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys &&
    cat ~/id.slave1 >> ~/.ssh/authorized_keys &&
    cat ~/id.slave2 >> ~/.ssh/authorized_keys

    - In slave 1
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys &&
    cat ~/id.master >> ~/.ssh/authorized_keys &&
    cat ~/id.slave2 >> ~/.ssh/authorized_keys

    - In slave 2
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys &&
    cat ~/id.master >> ~/.ssh/authorized_keys &&
    cat ~/id.slave1 >> ~/.ssh/authorized_keys


# Installing hadoop
unarchive hadoop folder in /usr/local
update java_home in hadoop-env.sh
update core-site.xml
update hdfs-site.xml
update yarn-site.xml

# Adding Hadoop and Java to path
HADOOP_INSTALL=/opt/hadoop-3.2.1
PDSH_RCMD_TYPE=ssh
PATH=$PATH:$HADOOP_INSTALL/bin:$HADOOP_INSTALL/sbin

JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_HOME

install java & jps
sudo apt install openjdk-8-jdk
sudo apt install openjdk-8-jdk-headless


# Très bon tutoriel
https://www.linode.com/docs/databases/hadoop/how-to-install-and-set-up-hadoop-cluster/#format-hdfs


# E.g Copy les confs de hdfs-site sur slave2
scp /usr/local/hadoop-3.2.1/etc/hadoop/hdfs-site.xml wilcoln@slave2:/usr/local/hadoop-3.2.1/etc/hadoop/

# Procédure d'installation

1. Copier le dossier hadoop-install dans tous les slaves
2. 