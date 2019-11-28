# 1. Download this script

```
sudo apt install git  -y && 
git clone https://github.com/wilcoln/hadoop-install.git
```

# 2. Set Hadoop configurations
- Set appropriately the variables in `conf/config.sh`
- Fill in `conf/hosts` with the hostname and IP address of all nodes in the cluster
- Edit all files in `conf/hadoop/` appropriately

# 3. Install hadoop
`cd  ~/hadoop-install && ./install-hadoop.sh`