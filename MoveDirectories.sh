#!/bin/bash

#############################################################################
# Move directories with names that contain specific integers/characters to  #
# destination directories based on the integers/characters that are matched #
######################### written by Phil Walker ############################
#############################################################################

# This method uses 'FOR' loops and 'IF' statements to search for specific
# integers/characters included in a directory name and then move any matching
# directories to a specific destination directory based on the integers/characters
# that are matched.
# Wilcards are used so that any directories that includes the integers/characters
# at any point are moved

########################################################################
#                            Variables                                 #
########################################################################

# Directory to move directories/files from
SRC_DIR="/path/to/source/directory"
# Directories to move directories/files to
DEST_DIR1="/destination/folder/for/integer/character/one"
DEST_DIR2="/destination/folder/for/integer/character/two"
DEST_DIR3="/destination/folder/for/integer/character/three"
DEST_DIR4="/destination/folder/for/integer/character/four"
#Temp text file
#FILMLIST="/tmp/directories.txt"

########################################################################
#                            Functions                                 #
########################################################################

function checkDirectory ()
{

local ITEMS=$(ls $SRC_DIR | wc -l)

if [[ $ITEMS -eq "0" ]]; then
  echo "No directories or files found, nothing to do"
  exit 1
fi

}

function move1 ()
{
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"int/char1"* ]]; then

      mv "$SRC_DIR"/"$d" "$DEST_DIR1"
      echo "Moved '$d' to '$DEST_DIR1'"

  fi
done
}

function move2 ()
{
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"int/char2"* ]]; then

      mv "$SRC_DIR"/"$d" "$DEST_DIR2"
      echo "Moved '$d' to '$DEST_DIR2'"

  fi
done
}

function move3 ()
{
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"int/char3"* ]]; then

      mv "$SRC_DIR"/"$d" "$DEST_DIR3"
      echo "Moved '$d' to '$DEST_DIR3'"

  fi
done
}

function move4 ()
{
IFS=$'\n'
#  for d in $(cat $FILMLIST); do
  for d in */; do

    if [[ $d = *"int/char4"* ]]; then

      mv "$SRC_DIR"/"$d" "$DEST_DIR4"
      echo "Moved '$d' to '$DEST_DIR4'"

  fi
done
}

function postMoveCheck ()
{

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

########################################################################
#                         Script starts here                           #
########################################################################

# Check to see if any files or folders exist before executing commands
checkDirectory

cd $SRC_DIR

#find * -maxdepth 0 -type d > /tmp/directories.txt

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
