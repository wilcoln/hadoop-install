# Install 

```
cd
wget https://github.com/wilcoln/hadoop-install/archive/master.zip
unzip master.zip && rm -rf master.zip
mv hadoop-install-master hadoop-install
```

# Settings
- Set appropriately the variables in `conf/config.sh`
- Fill in `conf/hosts` with the hostname and IP address of all nodes in the cluster
- Fill in `conf/hadoop/workers` with the hostname of all the workers in the hadoop cluster
- Edit all files in `conf/hadoop/` appropriately

# Run
On all nodes of the cluster, run

`cd hadoop-install && ./install-hadoop.sh`
