#!/bin/bash

########################################################################
# Rename files contained in the directory specified prompting the user #
# to specify the new file name                                         #
######################## written by Phil Walker ########################
########################################################################

# Script uses a 'For' loop to read each line of a text file that contains the file names
# of all files stored in the directory specified in the variable COMPL_DL.
# The user is then prompted for the new name and the file is renamed

# mv command uses verbose option to confirm what the file was renamed from and to

# SRC_DIR variable can be changed based on the requirements

########################################################################
#                            Variables                                 #
########################################################################

SRC_DIR="/path/to/source/directory"

########################################################################
#                            Functions                                 #
########################################################################

function checkDirectory ()
{

local ITEMS=$(ls $SRC_DIR | wc -l)

if [[ $ITEMS -eq "0" ]]; then
  echo "No files found, nothing to do"
  exit 1
fi

}

########################################################################
#                         Script starts here                           #
########################################################################

# Check to see if any files exist before executing commands
checkDirectory

cd $SRC_DIR

find * -maxdepth 0 -type f > /tmp/filelisting.txt

FILELISTING="/tmp/filelisting.txt"

IFS=$'\n'
for FILE in $(cat $FILELISTING); do
    echo "Rename '$FILE' to:"
    read NAME
    mv -v "$FILE" "$NAME.${FILE##*.}"
done

exit 0
