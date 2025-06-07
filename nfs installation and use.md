# Full name：Network File System
# Function: Let two hosts on the same network share files, just like Ubuntu and the host share the host
## Install on the server nfs：
    1. ```sudo apt-get install nfs-kernel-server```
    2. ```sudo apt-get install nfs-common```
        If you cannot install it, you need to change the source
    3. Writing configuration files
        ```sudo vim /etc/exports```
        The configuration content is as follows：
        ```/home/chenqiwen/nfs *(insecure,rw,sync,no_root_squash)```
    4. Create a shared folder, the path should be the same as the configuration file
    5. Restart the nfs service
        ```sudo service nfs-kernel-server restart```

## Install nfs on the client             
1. Install the driver
```
sudo apt-get install nfs-common
```
2. Create a local mount directory
```
mkdir /tmp/nfs
```
3. Mount the contribution directory
```
mount -t nfs -o nolock 172.16.5.170:/home/chenqiwen/nfs /tmp/nfs
ulimit -c unlimited
echo "/tmp/nfs/%e-%p-%t.coredmp" > /proc/sys/kernel/core_pattern
```

## Development board configuration nfs
~~~c
The development board system configuration supports nfs. Run the nfs_start.sh script to start the nfs function.
Mount after starting the nfs service
```
cd ~
nfs_start.sh 
umount /tmp/nfs
rm -rf /tmp/nfs
mkdir /tmp/nfs
mount -t nfs -o nolock 172.16.5.170 :/home/chenqiwen/nfs /tmp/nfs
cd /tmp/nfs
ls
```
The above commands can be written into a script file and run at startup.

At this time, you can directly access the contents of 172.16.5.170:/home/chenqiwen/nfs in the /tmp/nfs directory of the development board.
~~~


