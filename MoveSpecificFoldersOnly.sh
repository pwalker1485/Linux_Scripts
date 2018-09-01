#!/bin/bash

########################################################################
# Move directories with names containing specific integers/characters  #
# (set in the case statement) to the corresponding directory that also #
# contain that same integers/characters in the name                    #
######################## written by Phil Walker ########################
########################################################################

# This method prompts the user to enter the film quality they wish to be moved
# from the download directory to the correct relevant destination directory
# (They can enter any of the following 720p|1080p|3D|4K).
# A case statement is then used to test strings against the patterns specified
# and then move any directory found that contains that pattern if its enclosed in ()

#########################
#       Variables       #
#########################

#Directory to move directories/files from
SRC_DIR="/path/to/source/directory"

#########################
#       Functions       #
#########################

function checkDirectory() {

local ITEMS=$(ls $SRC_DIR | wc -l)

if [[ $ITEMS -eq "0" ]]; then
  echo "No directories found, nothing to do"
  exit 1
fi

}

function postMoveCheck() {

local CHECK_DIR=$(ls "$SRC_DIR" | grep "$FILM" | wc -l)

if [ $CHECK_DIR -eq "0" ]; then
  echo
  echo "All $FILM folders successfully moved to $DIR"
  echo
else
  echo
  echo "Data transfer failed, please run again..."
  echo
  exit 1
fi

}

##########################
#   script starts here   #
##########################

# Check to see if any files or folders exist before executing commands
checkDirectory

read -p "Enter the Film quality: " FILM
case $FILM in
  720p|1080p|3D|4K)

    #Directory to move directories/files to
    DIR="/path/to/destination/directory/$FILM/"
    DIR4K="/path/to/destination/directory/4K/"

    if [ $FILM = "4K" ];then
      DIR=$DIR4K
    fi

    echo
    echo "All folders with ($FILM) in the name will now be moved from $SRC_DIR to $DIR"

    echo
    echo "Moving..."
    echo

    mv -v $SRC_DIR/*\($FILM\)* $DIR

    postMoveCheck

    exit 0
    ;;

  *)

    echo "Incorrect film quality entered, nothing has been moved"

    ;;

  esac

  exit 0
