### Disk partition
### json

### udhcpc udhcpd

```
C-S model service based on DHCP (Dynamic Host Configuration Protocol)
udhcpc: DHCP client,
udhcpd: DHCP server

```

### access()

```c
#include <unistd.h>
int access(const char *pathname, int mode);
mode specifies the function of access, the values ​​are as follows
F_OK, value 0, determine whether the file exists
X_OK, value 1, determine whether the file has executable permission
W_OK, value 2, determine whether the file has write permission
R_OK, value 4, determine whether the file has read permission
The last three can be used together with '|'
```

### find file search command
Find files by file name
Usage: find directory -name "[file name]"

### grep string search command
Search for a specified string in a directory
-i ignores case
Usage:
1. grep -r "[string]" directory
2. cat .config | grep make

### cd - return to the previous directory
Return to the previous directory

### readelf to view the static library version information
View the static library version information command
readelf ./libtuya_ipc.a -p .comment

### | pipe symbol
Add a | . between two Linux commands
Treat the data originally output to the screen as the standard input of the next command
For example: history | grep date means that the result of running the history command contains "date"

### cut cutting command
Extract content in segments
For example
cat /proc/net/rtl8188fu/wlan0/rx_signal | grep rssi | cut -d ":" -f 2
The file in the directory
Originally, the content of the file was to be output to the screen. The pipe command makes the output result the standard
input of the grep command. The grep command searches for content containing 'rssi', and then the cut command extracts it in segments: The process is as follows
The result is segmented by :, and the second segment is extracted

### which search command path and alias

```
[root@localhost ~]: which pwd
[root@localhost ~]: /usr/bin/pwd
```

### whereis search command path and help document location

```
[root@localhost ~]: whereis ls
ls: /bin/ls /usr/share/man/man1/ls.1.gz /usr/share/man/man1/ls.1posix.gz
```

### mount mount command

```
Mount /dev/hda1 under /mnt
mount /dev/hda1 /mnt
```

### dmesg displays information when the computer starts

```
When the computer starts, a lot of information will be printed, and we can get a lot of system information from it.
dmesg | grep cpu // View information about the word cpu
```

### netstat monitors TCP/IP network tools

```
It can display routing tables, actual network connections, and the status information of each network interface device
-a displays all connected sockets
-n displays the direct use of ip addresses without going through domain name servers
-t displays the connection status of TCP transport protocol
-u displays the connection status of UDP transport protocol
-p displays the program identification code and program name of the socket in use

[root@anyka ~]$ netstat -antp
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address Foreign Address State PID/Program name
tcp 0 0 0.0.0.0:6789 0.0.0.0:* LISTEN 471/anyka_ipc
tcp 0 0 0.0.0.0:6790 0.0.0.0:* LISTEN 471/anyka_ipc
tcp 0 0 0.0.0.0:6791 0.0.0.0:* LISTEN 471/anyka_ipc
tcp 0 0 0.0.0.0:554 0.0.0.0:* LISTEN 471/anyka_ipc
tcp 0 0 127.0.0.1:8782 0.0.0.0:* LISTEN 464/cmd_serverd
tcp 0 0 0.0.0.0:8090 0.0.0.0:* LISTEN 471/anyka_ipc
```

### telnet

```
Telnet is the standard protocol and main method for remote login, which provides users with the ability to complete remote host work on the local computer.
You can use the telnet command to test whether the port number is normal or closed
telnet [ip] [port]
```

### Reentrant function

```
Reentrant functions are mainly used in multitasking environments. A reentrant function is simply a function that can be interrupted, that is, it can be interrupted at any time during its execution, and the system scheduler can execute another section of code, and there will be no errors when returning control; while non-reentrant functions use some system resources, such as the global variable area and the interrupt vector table, so if they are interrupted, problems may occur. Such functions cannot be run in a multitasking environment.
```

### free

```
Show the usage of system memory, including physical memory, swap memory (swap) and kernel buffer memory
[root@anyka /var/log]$ free
total used free shared buff/cache available
Mem: 59752 7608 49064 24 3080 47872
Swap: 0 0 0
Mem: memory usage
Swap: swap space usage
total: displays the total available physical memory and swap space size
used: displays the physical memory and swap space that have been used
free: displays how much physical memory and swap space are available
shared: displays the size of physical memory used by sharing
buff/cache: displays the size of physical memory used by buffer and cache
available: displays the size of physical memory that can still be used by applications
```

