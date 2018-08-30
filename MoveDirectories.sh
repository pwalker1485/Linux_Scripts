#!/bin/bash

########################################################################
############## Move downloaded films to correct directory ##############
######################## written by Phil Walker ########################
########################################################################

# This method uses 'FOR' loops and 'IF' statements to search for a pattern included
# in a directory name and then moves any matching directories to a specific alternative
# directory
# Wilcards are used so that any directory that includes the pattern at any point is
# moved

#########################
####### Variables #######
#########################

#Directory to move directories/files from
SRC_DIR="/path/to/source/directory"
DEST_DIR1="/destination/folder/for/pattern/one"
DEST_DIR2="/destination/folder/for/pattern/two"
DEST_DIR3="/destination/folder/for/pattern/three"
DEST_DIR4="/destination/folder/for/pattern/four"
#Temp text file
#FILMLIST="/tmp/filmdirectories.txt"

#########################
####### Functions #######
#########################

function postMoveCheck() {

local CHECK_DIR=$(find "$SRC_DIR" -type d | egrep "720p|1080p|3D|4K" | wc -l)

if [ "$CHECK_DIR" -eq "0" ]; then
  echo "All 720p/1080p/3D and 4K film folders successfully moved"
  echo

else
  echo "Data transfer failed, please run again..."
  echo
  exit 1

fi

}

function moveFilms720() {
IFS=$'\n'
#  for FILM in $(cat $FILMLIST); do
  for FILM in */; do

    if [[ $FILM = *"720p"* ]]; then
      echo "Moving '$FILM' to '$DEST_DIR1'"
      mv "$SRC_DIR"/"$FILM" "$DEST_DIR1"

  fi
done
}

function moveFilms1080() {
IFS=$'\n'
#  for FILM in $(cat $FILMLIST); do
  for FILM in */; do

    if [[ $FILM = *"1080p"* ]]; then

      echo "Moving '$FILM' to '$DEST_DIR2'"
      mv "$SRC_DIR"/"$FILM" "$DEST_DIR2"

  fi
done
}

function moveFilms3D() {
IFS=$'\n'
#  for FILM in $(cat $FILMLIST); do
  for FILM in */; do

    if [[ $FILM = *"3D"* ]]; then

      echo "Moving '$FILM' to '$DEST_DIR3'"
      mv "$SRC_DIR"/"$FILM" "$DEST_DIR3"

  fi
done
}

function moveFilms4K() {
IFS=$'\n'
#  for FILM in $(cat $FILMLIST); do
  for FILM in */; do

    if [[ $FILM = *"4K"* ]]; then

      echo "Moving '$FILM' to '$DEST_DIR4'"
      mv "$SRC_DIR"/"$FILM" "$DEST_DIR4"

  fi
done
}

##########################
### script starts here ###
##########################

cd $SRC_DIR

#find * -maxdepth 0 -type d > /tmp/filmdirectories.txt

echo "Checking for 720p films in '$SRC_DIR'..."
echo "--------------------------------------"
moveFilms720
echo "--------------------------------------"

echo
echo "Checking for 1080p films in '$SRC_DIR'..."
echo "--------------------------------------"
moveFilms1080
echo "--------------------------------------"

echo
echo "Checking for 3D films in '$SRC_DIR'..."
echo "--------------------------------------"
moveFilms3D
echo "--------------------------------------"

echo
echo "Checking for 4K films in '$SRC_DIR'..."
echo "--------------------------------------"
moveFilms4K
echo "--------------------------------------"

echo "Checking all films have been moved successfully..."
echo
postMoveCheck

exit 0
