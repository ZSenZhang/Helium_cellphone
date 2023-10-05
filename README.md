# Helium Cell Track

## Overview
- To test the cell phone's signal coverage, we are going to ship mobile devices through the way and having mobile devices do the experiment itself through the way. To achieve this, we use [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm&hl=en_US&gl=US) to run the scripts automatically. And set up a server to capture the UDP packet sending from mobile devices.

## Mobile phone setup
### Connect the phone to your computer
- First of all connect the phone to your laptop through USB cable. There should be a permission alert show up on the phone. If not, please open up the *Settings*. Scroll down to the bottom, go to *Developer options* section. Turn off and turn on the *USB debugging* buttons, the permission alert should show up. Give the permission to the computer.

### Open your teminal:
- If you are using Mac OS or Linux: Use `adb devices` to make sure the phone has already connected to your laptop. Then type `adb tcpip 5555`. The experiment should restart.
- If you are using Windows: Get to the dir where you downloaded the adb. Use `./adb devices` to check the connection of the phone. Then type `./adb tcpip 5555`.

### Restart the experiment:
- Go to the Tasker app on the phone, find the right tasker and switch on the button. You can change the duration of the task to control the time gap between each experiment. The script for the experiment is [RoudTripCellular6a.sh](https://github.com/ZSenZhang/Helium_cellphone/blob/main/RoudTripCellular6a.sh). You can also change the script according to your requirement and use `adb push <filename> /data/local/tmp` to push the script onto Android.

### If you don't have adb on your computer:
- For Windows: Download the ZIP file from here. https://dl.google.com/android/repository/platform-tools-latest-windows.zip
- For Mac OS: `brew cask install android-platform-tools`
- For Linux: `sudo apt-get install android-tools-adb`

### shipping instructions:
- please ship by cheapist ground 

## Setup a server to capture UDP packets
### Requirement
All you need is to have a server with public IP addresses, and use `screen` to run `tcpdump` to capture the UDP packets from phone. 

### Command for setting up the UDP server
The command to set up a UDP server listen to port 62234 to receive signal: `sudo tcpdump -i any port 62234 -n`. Don't forget change the ip address and port number in tasker's command line.

### Start a server with public IP address
If you have a server controlled by yourself, you can use UCSD's VPN which will give you a public IP address, or you can use AWS ec2 server.