#!/bin/bash

########################################################################
# Rename files contained in the directory specified prompting the user #
# to specify the new file name                                         #
######################## written by Phil Walker ########################
########################################################################

# Script uses a 'For' loop to read each line of a text file that contains the file names
# of all files stored in the directort specified in the variable COMPL_DL.
# The user is then prompted for the new name and the file is renamed

# mv command uses verbose option to confirm what the file was renamed from and to

# COMPL_DL variable can be changed based on the requirements

#########################
#       Variables       #
#########################

COMPL_DL="/path/to/source/directory"

cd $COMPL_DL

find * -maxdepth 0 -type f > /tmp/tvfilelisting.txt

FILELISTING="/tmp/tvfilelisting.txt"

IFS=$'\n'
for FILE in $(cat $FILELISTING); do
    echo "Rename '$FILE' to:"
    read NAME
    mv -v "$FILE" "$NAME.${FILE##*.}"
done

exit 0
