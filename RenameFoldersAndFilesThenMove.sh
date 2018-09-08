#!/bin/bash

#############################################################################
# Rename all directories and files (contained within those directories)     #
# prompting the user to specify the new directory and file names. Then move #
# directories with names that contain specific integers/characters to       #
# destination directories based on the integers/characters that are matched #
######################## written by Phil Walker #############################
#############################################################################

# Renaming method

# Script uses 'For' loops to read each line of text files that contain the directory names
# and names of the files contained in the directories, prompt the user to specify
# a new directory/file name and then rename the directory/file to that new name

# mv command uses verbose option to confirm what the directory/file was renamed from and to

# Move method

# This method uses 'FOR' loops and 'IF' statements to search for specific
# integers/characters included in a directory name and then move any matching
# directories to a specific destination directory based on the integers/characters
# that are matched.
# Wilcards are used so that any directories that includes the integers/characters
# at any point are moved

#########################
#       Variables       #
#########################

# Directory to move directories/files from
SRC_DIR="/path/to/source/directory"
# text file listing all directories in the source directory
DIRLISTING="/tmp/directorylisting.txt"
# text file listing all files contained within those directories
FILELISTING="/tmp/filelisting.txt"
# Directories to move directories/files to
DEST_DIR1="/destination/folder/for/integer/character/one"
DEST_DIR2="/destination/folder/for/integer/character/two"
DEST_DIR3="/destination/folder/for/integer/character/three"
DEST_DIR4="/destination/folder/for/integer/character/four"

#########################
#       Functions       #
#########################

function checkDownloadDirectory() {

local ITEMS=$(ls $SRC_DIR | wc -l)

if [[ $ITEMS -eq "0" ]]; then
  echo "No directories or files found, nothing to do"
  exit 1
fi

}

function renameDirectories() {
# write directory names to txt file
find * -maxdepth 0 -type d > /tmp/directorylisting.txt

# loop through each line in the directory listing text file, prompt to rename and then rename
IFS=$'\n'
  for DIR in $(cat $DIRLISTING); do

      echo "Rename '$DIR' to:"
      read NAME
      mv -v "$DIR" "$NAME"

  done
}

function renameFiles() {
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
}

function move1() {
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"int/char1"* ]]; then
      echo "Moving '$d' to '$DEST_DIR1'"
      mv "$SRC_DIR"/"$d" "$DEST_DIR1"

  fi
done
}

function move2() {
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"int/char2"* ]]; then

      echo "Moving '$d' to '$DEST_DIR2'"
      mv "$SRC_DIR"/"$d" "$DEST_DIR2"

  fi
done
}

function move3() {
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"int/char3"* ]]; then

      echo "Moving '$d' to '$DEST_DIR3'"
      mv "$SRC_DIR"/"$d" "$DEST_DIR3"

  fi
done
}

function move4() {
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"int/char4"* ]]; then

      echo "Moving '$d' to '$DEST_DIR4'"
      mv "$SRC_DIR"/"$d" "$DEST_DIR4"

  fi
done
}

function postMoveCheck() {

local CHECK_DIR=$(find "$SRC_DIR" -type d | egrep "int/char1|int/char2|int/char3|int/char4" | wc -l)

if [ "$CHECK_DIR" -eq "0" ]; then
  echo "'All int/char1'/'int/char2'/'int/char3' and 'int/char4' directories successfully moved"
  echo

else
  echo "Data transfer failed, please run again..."
  echo
  exit 1

fi

}

##########################
#   script starts here   #
##########################

checkDownloadDirectory

cd $SRC_DIR

renameDirectories
renameFiles

echo "Checking for int/char1 in '$SRC_DIR'..."
echo "--------------------------------------"
move1
echo "--------------------------------------"

echo
echo "Checking for int/char2 in '$SRC_DIR'..."
echo "--------------------------------------"
move2
echo "--------------------------------------"

echo
echo "Checking for int/char3 in '$SRC_DIR'..."
echo "--------------------------------------"
move3
echo "--------------------------------------"

echo
echo "Checking for int/char4 in '$SRC_DIR'..."
echo "--------------------------------------"
move4
echo "--------------------------------------"

echo "Checking all directories have been moved successfully..."
echo
postMoveCheck

exit 0
