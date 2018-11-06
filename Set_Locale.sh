#!/bin/bash

########################################################################
#               Set locales in /etc/default/locale file                #
######################## written by Phil Walker ########################
########################################################################

# Amend variables to suit locale required

########################################################################
#                            Variables                                 #
########################################################################

LANGUAGE='"en_GB:en"'
LANG=en_GB.UTF-8
LC_ALL=en_GB.UTF-8

########################################################################
#                         Script starts here                           #
########################################################################

apt-get install -y locales && sed -i -e "s/# $LANG.*/$LANG.UTF-8 UTF-8/" /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
update-locale LANG=$LANG
update-locale LANGUAGE=$LANGUAGE
update-locale LC_ALL=$LC_ALL

echo "locale settings all now set to English (GB)"

exit 0
