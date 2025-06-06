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
Generate uImage kernel image file in the build/arch/arm/boot path.
*	If you execute make clean directly in the kernel directory, the library files in the lib directory will be deleted. It is recommended to create a build directory in the same directory as kernel.
*	make O=../build -j4 uImage When compiling in this way, the ko files that drive the modules will not be compiled. If you need to, there are several ways：
a、	You can compile zImage directly without adding uImage, and then compile modules with make O=../build -j4 uImage command to compile uImage.
b、	Add modules to the end of the make O=../build -j4 uImage command to specify the target, make O=../bd -j4 uImage modules.
c、	Compile separately, use make O=../bd -j4 modules to compile the driver modules, and use make O=../build -j4 uImage to compile the kernel.
		
2. Application cloud platform configuration
The main application anyka_ipc needs to be compiled and configured. The path of the configuration file is platform/config.mk. Due to the different network configuration methods of different cloud platforms, the simultaneous operation support of multiple cloud platforms is not considered for the time being. Only one cloud platform support can be enabled. After selecting the cloud platform configuration, you also need to choose whether to support Wi-Fi configuration. The following describes the configuration items. Set y to enable and n to disable.：
```sh
	CONFIG_DANA_SUPPORT         = y           // Dana compilation configuration items (default)
	CONFIG_RTSP_SUPPORT         = n           // RTSP Function
	CONFIG_ONVIF_SUPPORT        = n           // ONVIF Platform
	CONFIG_ONVIF_AUDIO_SUPPORT  = n           // Does the ONVIF platform support audio input?
```
If the configuration in platform/config.mk is turned on, the corresponding macro definition will also be defined in the application code. For example, if CONFIG_DANA_SUPORT = y in platform/config.mk, then the macro CONFIG_DANA_SUPPORT in the application code will also be defined, and the code in the preprocessor #ifdef CONFIG_DANA_SUPPORT will be compiled.
Note: ONVIF configuration items conflict with RTSP and DANA configuration items and cannot be set to y at the same time, but RTSP configuration items do not conflict with DANA configuration items and can be y at the same time

3. File system configuration
The file system configuration file platform/rootfs/platform.cfg will automatically compile the cloud platform file system of the corresponding directory according to the configuration in platform/config.mk. Configure the utils switch in platform/config.mk, which is not turned on by default. If it is not turned on, the debugging/testing tools in the rootfs/utils directory will not be copied to the rootfs.
```sh
CONFIG_UTILS_SUPPORT = n         //utils configuration switches
```

Execute in sequence in the platform directory:
```sh
# make clean //Clean up old compilation results
# make //Compile all targets, including dynamic libraries
# make install //Generate the rootfs root file system directory content, including copying the compiled application
# make image //Pack the rootfs directory into a mirror file (root.sqsh4, usr.sqsh4, usr.jffs2)
```
Finally, three file system image files, root.sqsh4, usr.sqsh4 and usr.jffs2, are generated in the rootfs directory

## Chapter 4 System Operation Configuration
The system operation configuration mainly includes the following files
1. The anyka_cfg.ini configuration file provides various configuration parameters for the main application
2. The danale.conf configuration file saves the device login information of the Danale platform
3. isp_xx.conf and others are ISP parameter configuration files
Note: For detailed parameter configuration, please refer to "Cloud39EV300 Platform User Development Manual_V1.0.0"

## Chapter 5 Install and upgrade the development board
1. Burn the image file
Note: The following content briefly introduces the burning process of the development board. For details, please refer to the "Cloud39EV200 Platform Development Board User Manual"
* Check whether the JP4 and JP10 jumpers on the baseboard are configured as USB burning mode, that is: USB_DP->AK_DP, USB_DM->AK_DM.
* Copy the four files uImage, root.sqsh4, usr.jffs2, and usr.sqsh4 generated by the compilation to the directory of the burning tool;
* Run the BurnTool burning tool that comes with the PDK.
* Use a USB cable to connect the developed USB interface to the PC USB port.
* Press the USB power switch to turn on the power of the development board
* Long press the [BOOT] button on the baseboard, and short press the [RESET] button on the chip core board at the same time. Release the [BOOT] button after the burning tool enters the burning mode (the corresponding channel status turns yellow).
* In the burning tool interface, click the "Start" button to execute burning and wait for burning to complete.
* After burning is successful, short press the [RESET] button on the chip board to reset and boot.

2. Development board image upgrade
Note: You can upgrade through TF card or network
* Put the compiled uImage, root.sqsh4, usr.jffs2, usr.sqsh4 files (just put the corresponding image files as needed) into the /tmp directory on the development board through TF card or network
* Execute the update.sh command and wait for the upgrade to complete and restart.

## Chapter 6 Common Development Environment Configuration
1. How to use NFS file system to start
* During the development stage, it is recommended to use NFS as the development environment, which can save the work of remaking and burning the root file system.
* Operation command to mount the NFS file system:
```sh
# mount -t nfs -o nolock -o tcp xx.xx.xx.xx:/your-nfs-path /mnt
```
* Then you can access the files on the server in the /mnt directory and perform development work.

2. How to run and stop the main program
Note: By default, the main program is in the /usr/bin directory, and the executable file is named anyka_ipc
There are two ways to stop the main program:
* Method 1: Use a script to stop the service. Execute the service.sh stop command to stop the running program (including anyka_ipc and daemon, etc.)
* Method 2: Use the kill or killall command to kill the process directly (note that you need to kill the daemon process first, and then kill the anyka_ipc process)

Start the main program:
Manually starting the main program is mainly to facilitate debugging using the NFS file system. Users need to mount the program to be debugged to the development board through the NFS file system, and then switch to the directory where the program to be debugged is located to execute the program, for example: ./anyka_ipc &

3. Enable telnet service
After the network is normal, the telnet service is generally enabled; if it is not enabled, run the command telnetd& to start the single-board telnet service, and use telnet to log in to the single board.

4. Enable log printing
Execute tail -F /var/log/message& to enable log printing.
