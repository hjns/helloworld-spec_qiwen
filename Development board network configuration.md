# Linux connects to wireless network wpa_cli, wpa_supplicant
    The wpa_supplicant package contains the client program wpa_cli, which can be used to directly connect to a wireless network without the usual wireless network configuration file method, which is useful in some special cases.
    
## Start wpa_supplicant Start wpa_supplicant in daemon mode:
``` 
wpa_supplicant -B -i wlan0 -D wext -c /etc/wpa_supplicant.conf
-B daemon mode
-i wireless network card name
-D driver type
-c configuration file directory   
```
    wlan0 is the device name of the wireless network card in the system. The configuration file is /etc/wpa_supplicant.conf ,
and you can add the information needed to connect to the network in the file. The following is an example tuyav200
```
ctrl_interface=/var/run/wpa_supplicant
ap_scan=1
network={
    ssid="Hiwifi_2.4G"
    key_mgmt=WPA-PSK
    pairwise=CCMP TKIP
    group=CCMP TKIP WEP104 WEP40
    psk="licheng.chn"
    scan_ssid=1
}
```
    ssid wifi name
    psk WiFi Password

## Start wpa_cli
```
wpa_cli -i wlan0
```

## Add a network and set network parameters
You can first use the status command to query the network connection status, which should return
``` wpa_state=DISCONNECTED ```
You can first scan the network to view all current wifi names
scan Search for wireless networks
scan_result Display search results
Use the following command to add a network and set the corresponding parameters
``` add_network ```
This command will return the newly added network ID, which is usually 0. The first parameter of the following command is the network ID
``` set_network 0 ssid "wyk" ```
wyk is the wireless network name, which should be enclosed in quotation marks
``` set_network 0 psk "password" ```
password represents the network password, which should also be enclosed in quotation marks
### Disconnect network number
``` disconnect network number ```
### Delete network cable
``` remove_network network number```

## Enable network
``` enable_network 0 ```
After the command is executed, wpa_cli will output the connection process information. If everything is normal, it will output
``` CTRL-EVENT-CONNECTED...

wpa_supplicant -B -iwlan0 -Dwext -c /etc/jffs2/wpa_supplicant.conf

```

### Configure gateway command

```
sudo route add default gw [gateway ip]
```

### View gateway command

```
route
```

