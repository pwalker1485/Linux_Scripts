#!/bin/bash

############################################################################
# Move directories with names that contain specific strings to destination #
# directories based on the string that is matched                          #
######################### written by Phil Walker ###########################
############################################################################

# This method uses 'FOR' loops and 'IF' statements to search for a string included
# in a directory name and then move any matching directories to a specific destination
# directory based on the string that is matched
# Wilcards are used so that any directories that includes the string at any point are
# moved

#########################
#       Variables       #
#########################

#Directory to move directories/files from
SRC_DIR="/path/to/source/directory"
DEST_DIR1="/destination/folder/for/string/one"
DEST_DIR2="/destination/folder/for/string/two"
DEST_DIR3="/destination/folder/for/string/three"
DEST_DIR4="/destination/folder/for/string/four"
#Temp text file
#FILMLIST="/tmp/directories.txt"

#########################
#       Functions       #
#########################

function postMoveCheck() {

local CHECK_DIR=$(find "$SRC_DIR" -type d | egrep "string1|string2|string3|string4" | wc -l)

if [ "$CHECK_DIR" -eq "0" ]; then
  echo "All string1/string2/string3 and string4 directories successfully moved"
  echo

else
  echo "Data transfer failed, please run again..."
  echo
  exit 1

fi

}

function movestring1() {
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"string1"* ]]; then
      echo "Moving '$d' to '$DEST_DIR1'"
      mv "$SRC_DIR"/"$d" "$DEST_DIR1"

  fi
done
}

function movestring2() {
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"string2"* ]]; then

      echo "Moving '$d' to '$DEST_DIR2'"
      mv "$SRC_DIR"/"$d" "$DEST_DIR2"

  fi
done
}

function movestring3() {
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"string3"* ]]; then

      echo "Moving '$d' to '$DEST_DIR3'"
      mv "$SRC_DIR"/"$d" "$DEST_DIR3"

  fi
done
}

function movestring4() {
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"string4"* ]]; then

      echo "Moving '$d' to '$DEST_DIR4'"
      mv "$SRC_DIR"/"$d" "$DEST_DIR4"

  fi
done
}

##########################
#   script starts here   #
##########################

cd $SRC_DIR

#find * -maxdepth 0 -type d > /tmp/directories.txt

echo "Checking for string one in '$SRC_DIR'..."
echo "--------------------------------------"
movestring1
echo "--------------------------------------"

echo
echo "Checking for string two in '$SRC_DIR'..."
echo "--------------------------------------"
movestring2
echo "--------------------------------------"

echo
echo "Checking for string three in '$SRC_DIR'..."
echo "--------------------------------------"
movestring3
echo "--------------------------------------"

echo
echo "Checking for string four in '$SRC_DIR'..."
echo "--------------------------------------"
movestring4
echo "--------------------------------------"

echo "Checking all directories have been moved successfully..."
echo
postMoveCheck

exit 0
