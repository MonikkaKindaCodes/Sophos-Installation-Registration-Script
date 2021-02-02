#!/bin/bash
mkdir /private/var/tmp/sophos
cd /private/var/tmp/sophos

#Removing Sophos
defaults write /Library/Preferences/com.sophos.sav TamperProtectionEnabled -int 0
killall -kill SophosServiceManager
/Library/Application\ Support/Sophos/saas/Installer.app/Contents/MacOS/tools/InstallationDeployer --remove

# Installing Sophos
curl -L -O "https://api-cloudstation-us-east-2.prod.hydra.sophos.com/api/download/c31b008ae3658cf18769e5f5eae213c7/SophosInstall.zip"
unzip SophosInstall.zip
chmod a+x /private/var/tmp/sophos/Sophos\ Installer.app/Contents/MacOS/Sophos\ Installer
chmod a+x /private/var/tmp/sophos/Sophos\ Installer.app/Contents/MacOS/tools/com.sophos.bootstrap.helper
sudo /private/var/tmp/sophos/Sophos\ Installer.app/Contents/MacOS/Sophos\ Installer --install;
/bin/rm -rf /private/var/tmp/sophos;

#Registering Sophos: REBOOT REQUIRED
sudo killall SophosConfigD 
sudo launchctl stop com.sophos.mcs 

#Running Recon to update to JAMF cloud
sudo jamf recon

exit 0      ## Success
exit 1      ## Failure
