#!/bin/bash

##################################################################################
############### Set permissions for directories and files ########################
###################### written by Phil Walker ####################################
##################################################################################

# Amend variables as per requirement

#########################
####### Variables #######
#########################

USER="username"
GROUP="groupname"

##########################
### script starts here ###
##########################

# exit this bash script if any statement returns a non-true return value
set -e

if [ -z "$1" ]; then
    echo
    echo "ERROR: Must pass parameter of path to directory"
    echo "USAGE: $0 /path/to/directory/*"
    echo
    exit 1
fi

read -p "Okay to continue (y/n)? "
if [ "$REPLY" != "y" ]; then
    echo
    echo "EXITING -- NO ACTION TAKEN."
    echo
    exit 1
fi

echo
echo "Starting..."
echo

find "$1" -type d -print0 | xargs -0 chmod 755
find "$1" -type f -print0 | xargs -0 chmod 644
find "$1" -type d -print0 | xargs -0 chown "$USER":"$GROUP"
find "$1" -type f -print0 | xargs -0 chown "$USER":"$GROUP"

echo "Done. Standard permissions and ownership now set"
echo

exit 0
