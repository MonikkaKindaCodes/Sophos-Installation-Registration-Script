#!/bin/bash

#Registering Sophos: REBOOT REQUIRED if connected to the VPN
sudo killall SophosConfigD 
sudo launchctl stop com.sophos.mcs 
