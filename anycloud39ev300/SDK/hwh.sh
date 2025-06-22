#!/bin/sh
#
# example:
#    ./auto_build.sh ak3918e_38module dana rtl8188 pdk_v1.0_dana_rtl8188
#
# Support boardname:
#             ak3918e_38module - ak3918ev300 38 module kernel config
#             ak3916e_corebd   - ak3916ev300 core board kernel config
#             ak3918e_corebd   - ak3918ev300 core board kernel config
# 	
# Support platform:
#             dana  -	dana cloud platform
#             rtsp  - rtsp platform
# 	
# Support wifi:
# 		rtl8188     - realtek 8188-eus usb-wifi
# 		rtl8188_ftv - realtek 8188-ftv usb-wifi
# 		rtl8189_etv - realtek 8189-etv sdio-wifi
# 		rtl8189_ftv - realtek 8189-ftv sdio-wifi
# 		hi3881		- hi 3881 sdio-wifi
# 		atbm603x	- atbm6032i usb-wifi
# 		nowifi		- no need wifi
# 
./auto_build.sh ak3918e_corebd dana atbm603x pdk_v1.0_rtsp_atbm603x | tee build.log 2>&1

