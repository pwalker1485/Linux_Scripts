#!/bin/bash

########################################################################
#                Install all available updates                         #
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

/usr/bin/apt-get -y update && /usr/bin/apt-get -y upgrade && /usr/bin/apt-get -y dist-upgrade

/bin/echo "---------------------------------------------------"
/bin/echo "*UPDATE SCRIPT*: All Updates and Upgrades completed"
/bin/echo "---------------------------------------------------"

/usr/bin/apt-get -y autoremove && /usr/bin/apt-get -y autoclean && /usr/bin/apt-get -y clean

/bin/echo "---------------------------------------------------"
/bin/echo "*UPDATE SCRIPT*: All old .deb files removed and package cache cleared"

exit 0
