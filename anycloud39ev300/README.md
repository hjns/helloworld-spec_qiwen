CLOUD39EV300 Platform SDK Quick Start Guide
===

## Chapter 1 Quick Start Guide Document Overview
This document is intended for product software development engineers to help them understand SDK-related content and quickly get started with development.
    
## Chapter 2 Installing and Using SDK for the First Time
1. SDK package format and version description
SDK is a compressed package, usually named like: CLOUD39EV300_SDK_Vx.x.x.tgz. Use the command: tar -zxf CLOUD39EV300_SDK_Vx.x.x.tgz to decompress it, and you will get a CLOUD39EV300_SDK_Vx.x.x directory, which is the SDK directory.

2. SDK Directory Introduction
```
CLOUD39EV300_SDK_Vx.x.x
├── doc
│   ├── Cloud39EV300Kernel Configuration and Modification Manual_V1.0.0.pdf
│   └── Cloud39EV300Platform User Development Manual_V1.0.0.pdf
├── kernel
├── platform
│   ├── apps
│   │   ├── akipc                          # The main application is responsible for audio and video acquisition encoding, network transmission, local recording and other functions.
│   │   ├── ccli                           # Dynamically obtain and set the running status of the application process
│   │   ├── cmd_serverd                    # Monitor and receive shell call requests from other processes, and initiate calls to shell commands
│   │   ├── daemon                         # Background daemon, responsible for: Monitoring the operation of anyka_ipc, recovering from abnormal exit, memory leak and kernel deadlock, etc. T card plug-in detection and key processing
│   │   ├── disk_repair
│   │   ├── Makefile
│   │   ├── mmc_test                       # TF card test program
│   │   ├── product_test                   # Production test program, mainly completes the testing of hardware such as image, audio, wifi and T card, as well as completes the burning of uid and mac addresses
│   │   ├── updater                        # The upgrade program can upgrade the boot, kernel, file system image and upgrade package. For kernel upgrade, it is necessary to distinguish between uImage and zImage to avoid mistakes.
│   │   └── version
│   ├── ChangeLog
│   ├── config.mk
│   ├── libapp                             # Application Layer
│   ├── libmpi                             # Multimedia layer
│   ├── libplat                            # Platform Layer
│   ├── Makefile
│   └── rootfs                             # File System
├── Quick Start Guide.txt
└── tools
    ├── anyka_uclibc_gcc.tar.bz2           # Cross-compilation tools
    ├── arm-anykav200-gdb-7.12.tar.gz      # gdb debugging tool
    └── burntool                           # Burning tool
```        

3. Install and configure the cross-compilation environment on the Linux server
* The cross-compilation tool is located in the tools directory of the SDK. The compressed package name of the tool chain provided by Ankai is anyka_uclibc_gcc.tar.bz2，
* Execute the following command in the root directory with root user privileges to decompress
```sh
# tar -Pxvf  anyka_uclibc_gcc.tar.bz2 
```
After decompression, the toolchain will be installed in the directory /opt/arm-anykav200-crosstool/. The toolchain uses an absolute path and must be placed in this directory to run properly. The directory and file names cannot be modified.
* Set the host PATH environment variable: Use export PATH=$PATH:/opt/arm-anykav200-crosstool/usr/bin to add it to the system's PATH variable. You can also add it to the system's startup script and modify files such as /etc/environment or /etc/bash.bashrc.
* Tool chain confirmation: After installation, execute arm-anykav200-linux-uclibcgnueabi-gcc –v. The system can find the command and display the version information of gcc, indicating that the tool is installed correctly.

## Chapter 3 Kernel and Platform Compilation Configuration Options
1. Kernel Configuration Options
Execute sequentially in the kernel directory：
```sh
	# mkdir ../build
	# make O=../build cloud39ev3_xx_defconfig
	# make O=../build -j4 uImage
```
生成uImage内核镜像文件，在build/arch/arm/boot 路径下。
*	如果直接在kernel目录下执行make clean会删除lib目录下的库文件，建议在kernel的同级目录下，新建一个build目录。
*	make O=../build -j4 uImage 这种方式编译时，是不会编译驱动modules的那些ko文件的，若需要有几种方法：
a、	可以先不加uImage 直接make O=../build -j4 编译出zImage ，同时会编译modules，再用make O=../build -j4 uImage命令编译出uImage。
b、	在make O=../build -j4 uImage命令后面再加上 modules指定目标，make O=../bd -j4 uImage modules。
c、	分开编译，用make O=../bd -j4 modules编译驱动modules，用make O=../build -j4 uImage编译内核。
		
2. 应用程序云平台配置
针对主应用程序anyka_ipc需要进行编译配置，配置文件的路径为platform/config.mk.因不同的云平台的网络配置方式不同，暂时未考虑多云平台的同时运行支持，仅可开启一种云平台支持。运择云平台配置后还要选择是否支持Wi-Fi配置。下面介绍配置项，设置y为开启，n主关闭：
```sh
	CONFIG_DANA_SUPPORT         = y           // 大拿编译配置项（默认）
	CONFIG_RTSP_SUPPORT         = n           // RTSP 功能
	CONFIG_ONVIF_SUPPORT        = n           // ONVIF平台
	CONFIG_ONVIF_AUDIO_SUPPORT  = n           // ONVIF平台是否支持音频输入
```
若platform/config.mk里的配置打开，应用的代码里，相应的宏定义也会被定义。比如platform/config.mk里CONFIG_DANA_SUPORT =y，那么应用代码里的宏CONFIG_DANA_SUPPORT也会被定义，在预处理#ifdef CONFIG_DANA_SUPPORT里面的代码将被编译。
注意：ONVIF配置项和RTSP及DANA配置项冲突，不能同时设为y，但RTSP配置项和DANA配置项不冲突，可以同时为y

3. 文件系统配置
文件系统的配置文件platform/rootfs/platform.cfg会自动根据platform/config.mk里的配置来编译相应目录的云平台的文件系统。在platform/config.mk里配置utils开关，默认不打开。若没有打开，rootfs/utils目录下的调试/测试工具是不会被拷贝到rootfs下的。
```sh
CONFIG_UTILS_SUPPORT = n         //utils配置开关
```

在platform目录下顺序执行：
```sh
	# make clean                      //清理旧的编译结果
	# make                            //编译所有目标，包括动态库
	# make install                    //生成rootfs根文件系统目录内容，包括拷贝已编译好的应用程序
	# make image                      //打包rootfs目录成镜像文件(root.sqsh4、usr.sqsh4、usr.jffs2)
```
最终在rootfs目录下生成root.sqsh4、usr.sqsh4和usr.jffs2三个文件系统镜像文件

## 第四章 系统运行配置
系统运行配置主要包括以下文件
1. anyka_cfg.ini配置文件为主应用程序提供各项配参数
2. danale.conf配置文件保存大拿平台的设备登录信息
3. isp_xx.conf等是ISP参数配置文件
注意：详细参数配置请参考《Cloud39EV300平台用户开发手册_V1.0.0》

## 第五章 安装及升级开发板
1. 烧写镜像文件
注意：以下内容简要介绍了开发板的烧录过程，详细内容请参考《Cloud39EV200平台开发板使用说明》
* 检查底板板上的JP4和JP10跳线是否已配置为USB烧录模式，即：USB_DP->AK_DP，USB_DM->AK_DM。
* 把编译生成的uImage、root.sqsh4、usr.jffs2、usr.sqsh4四个文件拷贝到烧录工具的目录下；
* 运行PDK配套的BurnTool烧录工具。
* 使用USB线连接开发的USB接口到PC USB端口。
* 按USB供电开关接通开发板电源
* 长按底板上的【BOOT】键，同时短按芯片核心板上的【RESET】键，待烧录工具进入烧录模式（对应通道状态变黄色）后再松开【BOOT】键。
* 在烧录工具界面，单击“开始”按钮，执行烧录，等待烧录完成。
* 烧录成功后，短按芯片板上的【RESET】键复位并开机。

2. 开发板镜像升级
注意：可以通过TF卡或者网络进行升级
* 将编译生成的uImage、root.sqsh4、usr.jffs2、usr.sqsh4文件(根据需要放对应的镜像文件即可)通过TF卡或者网络放到开发板上的/tmp目录
* 执行update.sh命令，等待升级完成重启即可。

## 第六章 常用开发环境配置
1. 如何使用NFS文件系统启动
* 在开发阶段，推荐使用NFS作为开发环境，可以省去重新制作和烧写根文件系统的工作。
* 挂载NFS文件系统的操作命令：
```sh
		# mount -t nfs -o nolock -o tcp xx.xx.xx.xx:/your-nfs-path /mnt
```
* 然后就可以在/mnt目录下访问服务器上的文件，并进行开发工作。
	
2. 如何运行停止主程序
注意：默认情况下主程序在/usr/bin目录，可执行文件名为anyka_ipc
停止主程序可以使用两种方法：
* 方法一：使用脚本停止服务，执行service.sh stop命令即可停止正在运行的程序（包括anyka_ipc及daemon等）
* 方法二：使用kill或killall命令直接杀掉进程（注意需要先kill掉daemon进程，然后再kill掉anyka_ipc进程）

启动主程序：
手工启动主程序主要是为了方便使用NFS文件系统进行调试，用户需要通过NFS文件系统将待调试程序挂载到开发板，然后切换到待调试程序所在的目录执行程序，例如：./anyka_ipc &

3. 开启telnet服务
 网络正常后，一般情况下telnet服务已经开启；如未开启，运行命令 telnetd& 就可以启动单板telnet服务，使用telnet即可登录到单板。
	
4. 开启log打印
执行tail -F /var/log/message&开启log打印。
