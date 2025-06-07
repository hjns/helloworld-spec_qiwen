### ifi wireless network card accesses the Internet and serves as a personal hotspot

There are two ways for embedded devices to connect to the Internet: wired and wireless

Wired means plugging in a network card and connecting to a network cable

There are two types of wireless network cards: USB WiFi and SDIO WiFi

USB WiFi uses the USB interface (Universal Serial Bus), which is a serial bus standard that connects computer systems and external devices

SDIO WiFi uses the SDIO interface, which is an interface developed on the basis of the SD memory card interface

### WiFi network cards have two working modes:

### Wireless terminal mode (STA): Connect to the Internet through this mode

### Wireless hotspot mode (AP): Generate a hotspot through this mode for other devices to access the Internet

### The security of a wireless network consists of two parts: authentication and encryption

Authentication: Only running devices can connect to the wireless network

Encryption: Ensure the confidentiality and integrity of data and ensure that data will not be tampered with during transmission

|Security policy | Authentication method | Encryption method | Remarks |
| :------: | :-----------: | :------------------: | :--------------------: |
| open | open | open | Open wifi, no encryption |
| open | WEP | Open wifi, data encryption only | |
| WEP | WEP | WEP | Shared key authentication, easy to crack |
| WAP | 8002.11x | TKIP/WEP | Relatively safe, for enterprise |
| PSK | TKIP/WEP | Relatively safe, for personal | |
| WAP2 | 802.11X | CCMP/TKIP/WEP | Currently the most secure, for personal |
| PSK | CCMP/TKIP/WEP | Currently the most secure, for personal | |

​ When connecting to public wifi in supermarkets, you do not need to enter a password, but you need to enter your mobile phone number through the web page and use the verification code to verify, that is, use 802.11x for verification, and then complete the verification through the server

​ When using a mobile phone to open a personal hotspot, you can choose different security levels of open, wep, wap, and wap2

### If you want to use a wireless network card, you need to use the command

iw: can be used for open and wep "authentication/encryption", as well as scanning WiFi hotspots, and can replace iwconfig

wpa_supplicant: can be used for the previous 4 "authentication/encryption", it is a tool for connecting and configuring WiFi

hostapd: can switch the wireless network card to AP mode

dhcp: STA mode allows WiFi to dynamically obtain IP, and AP mode allocates IP

ifconfig: configure network card information

iwconfig: used for system configuration of wireless network devices or display of wireless network device information

iwlist: analyze the /proc/net/wireless file to obtain wireless network card related information

route:

### ifconfig

Simple analysis
```
[root@localhost ~]# ifconfig eth0
 
// UP: means "interface is enabled".
// BROADCAST: means "host supports broadcast".
// RUNNING: means "interface is working".
// MULTICAST: means "host supports multicast".
// MTU:1500 (maximum transmission unit): 1500 bytes
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST> mtu 1500

// inet: IP address of the network card.
// netmask: network mask.
// broadcast: broadcast address.
inet 192.168.1.135 netmask 255.255.255.0 broadcast 192.168.1.255

// IPv6 address of the network card
inet6 fe80::2aa:bbff:fecc:ddee prefixlen 64 scopeid 0x20<link>
// Connection type: Ethernet (Ethernet) HWaddr (hardware mac address)
// txqueuelen (transmit queue length set by the network card)
ether 00:aa:bb:cc:dd:ee txqueuelen 1000 (Ethernet)

// RX packets The number of correct packets when receiving.
// RX bytes The amount of data received.
// RX errors The number of packets with errors when receiving.
// RX dropped The number of packets dropped when receiving.
// RX overruns The number of packets lost due to excessive speed when receiving.
// RX frame The number of packets lost due to frame errors when receiving.
RX packets 2825 bytes 218511 (213.3 KiB)
RX errors 0 dropped 0 overruns 0 frame 0

// TX packets The number of correct packets when sending.
// TX bytes The amount of data sent.
// TX errors The number of packets with errors when sending.
// TX dropped The number of packets dropped when sending.
// TX overruns 发送时，由于速度过快而丢失的数据包数。
// TX carrier 发送时，发生carrier错误而丢失的数据包数。
// collisions 冲突信息包的数目。
TX packets 1077 bytes 145236 (141.8 KiB)
TX errors 0 dropped 0 overruns 0 carrier 0 collisions 0
```

Simple use case

Display activated network card information

```
ifconfig
```

Display all network card information

```
ifconfig -a
```

Start/stop wired/wireless network card

```
ifconfig wlan0/eth0 up/down
```

Configure ip, subnet mask

```
//Configure IP address
ifconfig eth0 192.168.1.100

//Configure IP address and subnet mask
ifconfig eth0 192.168.1.100 netmask 255.255.255.0
```

### iwconfig

Used for system configuration of wireless network devices or display of wireless network device information, the iwconfig command is similar to the ifconfig command, but its configuration object is the wireless network card

```
auto automatic mode
essid Set essid
nwid Set network id
freq Set wireless network channel
chanel Set wireless network channel
mode Set communication device of wireless network device
```

### iwlist

Simple use case

Search for current wireless network

```
iwlist wlan0 scanning
```

Display channel information

```
iwlist wlan0 frequen
```

Display connection speed

```
iwlist wlan0 rate
```

Show hotspot information

```
iwlist wlan0 ap
```

### iw

iw is a new nl80211 based ctl configuration utility for wireless devices. It supports all new drivers that have been added to the kernel recently

Simple use case

List the performance of the wifi card

```
iw list
```

Scan wifi hotspots

```
iw dev wlan0 scan
iw dev wlan0 scan | grep SSID
```

Connect to an open AP

```
iw wlan0 connect hceng
```

Check connection status

```
iw wlan0 link
```

Disconnect wifi connection

```
iw wlan0 disconnect
```

### wpa_supplicant

wpa_supplicant mainly includes two programs: wpa_supplicant (command line mode) and wpa_cli (interactive mode)

Simple use case: connect to an open network

Add to /etc/wpa_supplicant.conf:

```
network={
ssid="hceng"
key_mgmt=NONE
}
```

Initialize wpa_supplicant and execute:

```
wpa_supplicant -B -d -i wlan0 -c /etc/wpa_supplicant.conf
```

Check the connection status:

```
wpa_cli -i wlan0 status
```

Disconnect

```
wpa_cli -i wlan0 disconnect
killall wpa_supplicant
```

Reconnect

```
wpa_cli -i wlan0 reconnect
```

### dhclient

Usage example

Automatically obtain and assign IP, and set

```
dhclient wlan0
```

### AP mode generates hotspot

```

1), ifconfig wlan0 up

2), hostapd -B /etc/jffs2/hostapd.conf

3), udhcpd /etc/jffs2/udhcpd.conf

4), tcpsvd 0 21 ftpd -w /data &
```
