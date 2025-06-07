## Install
    ```sudo apt-get install samba samba-common```

## Set shared directory permissions
    ```sudo chomd 777 /home/china/share```

## Configure samba
    1. Modify the configuration file
    ```sudo vim /etc/samba/smb.conf```
    
    2. Jump to lines 261 - 272
    ```
    [shhare]
    comment = share folder
    browseable = yes
    path = /home/china/share
    create mask = 0777
    directory mask = 0777
    valid users = china
    force user = china
    force group = china
    public = yes
    available = yes
    writable = yes
    ```
    
## Adding Users
    ```sudo smbpasswd -a china```
    You will be prompted to enter your password

## Restart samba service
    ```sudo /etc/init.d/smbd restart```

## Windows
    win + R Open the Run window
    ``` \\192.168.10.231\share ```
    Enter the username and password you just added to access the shared files.
    
