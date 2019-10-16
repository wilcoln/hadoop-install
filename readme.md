# Procédure d'installation
Sur chaque noeud du cluster, faire:

```
wget https://github.com/wilcoln/hadoop-install/archive/master.zip
unzip master.zip && rm -rf master.zip
mv hadoop-install-master hadoop-install
cd hadoop-install && ./install-hadoop.sh
```
