#!/bin/bash

########################################################################
#           Install all available updates & upgrades                   #
################### Written by Phil Walker #############################
########################################################################

########################################################################
#                            Variables                                 #
########################################################################

TimeDate=$(date)

########################################################################
#                         Script starts here                           #
########################################################################

/bin/echo "---------------------------------------------------"
/bin/echo "*UPDATE SCRIPT*: $TimeDate"
/bin/echo "---------------------------------------------------"

/bin/echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
/usr/bin/apt-get -y update && /usr/bin/apt-get -y upgrade && /usr/bin/apt-get -y dist-upgrade

/bin/echo "---------------------------------------------------"
/bin/echo "*UPDATE SCRIPT*: All Updates and Upgrades completed"
/bin/echo "---------------------------------------------------"

/usr/bin/apt-get -y autoremove && /usr/bin/apt-get -y autoclean && /usr/bin/apt-get -y clean

/bin/echo "---------------------------------------------------"
/bin/echo "*UPDATE SCRIPT*: All old .deb files removed and package cache cleared"

#Rebooting system, due to some updates/upgrades requiring a reboot to complete
/bin/echo "---------------------------------------------------"
/bin/echo "*UPDATE SCRIPT*: Rebooting system to complete updates..."
/sbin/shutdown -r now

exit 0
