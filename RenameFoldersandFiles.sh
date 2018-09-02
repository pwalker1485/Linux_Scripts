#!/bin/bash

########################################################################
# Rename all directories and files contained within those directories  #
# prompting the user to specify the new directory and file names       #
######################## written by Phil Walker ########################
########################################################################

# Script uses 'For' loops to read each line of text files that contain the directory names
# and names of the files contained in the directories, prompt the user to specify
# a new directory name and then rename the directory or file to that new name

# mv command uses verbose option to confirm what the directory/file was renamed from and to

# SRC_DIR variable can be changed based on the requirements

#########################
#       Variables       #
#########################

# Source directory
SRC_DIR="/path/to/source/directory"
# text file listing all directories in the source directory
DIRLISTING="/tmp/directorylisting.txt"
# text file listing all files contained within those directories
FILELISTING="/tmp/filelisting.txt"

#########################
#       Functions       #
#########################

function checkDirectory() {

local ITEMS=$(ls $SRC_DIR | wc -l)

if [[ $ITEMS -eq "0" ]]; then
  echo "No directories or files found, nothing to do"
  exit 1
fi

}

##########################
#   script starts here   #
##########################

# Check to see if any files or folders exist before executing commands
checkDirectory

# Change directory into the source directory
cd $SRC_DIR

# write directory names to txt file
find * -maxdepth 0 -type d > /tmp/directorylisting.txt

# loop through each line in the directory listing text file, prompt to rename and then rename
IFS=$'\n'
for DIR in $(cat $DIRLISTING); do
    echo "Rename '$DIR' to:"
    read NAME
    mv -v "$DIR" "$NAME"
done

# re-populate directory names in txt file
find * -maxdepth 0 -type d > /tmp/directorylisting.txt
# write file names to txt file
find * -mindepth 1 -maxdepth 1 -type f > /tmp/filelisting.txt

# loop through each line in the file listing text file, prompt to rename and then rename (keeping the same file extension)
IFS=$'\n'
for FILE in $(cat $FILELISTING); do
    DIRNAME=$(echo "$FILE" | sed 's/\/.*//g')
    echo "Rename '$FILE' to:"
    read NAME
    mv -v "$FILE" "$DIRNAME"/"$NAME.${FILE##*.}"
done

exit 0
