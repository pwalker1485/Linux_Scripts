#!/bin/bash

###############################################################################
################ Move folders or file types to a new location #################
######################### written by Phil Walker ##############################
###############################################################################

#amend variable assignments for source/destination folders and strings for case statement as per your requirements

#The example below prompts the user to enter 720p/1080p/3D or 4K, then moves any folder with the string specified
#(enclosed in brackets) within the name to the destination folder.
#If any other value is entered nothing is moved
#An if statement is used to see if 4K is specified so that a different path can be assigend to the DIR variable

#specific file types could also be moved or all contents of the source folder

#########################
####### Variables #######
#########################

#Directory to move directories/files from
SRC_DIR="/media/Downloads/Downloads/Completed_Downloads"

#########################
####### Functions #######
#########################

function postMoveCheck() {

local CHECK_DIR=$(ls /media/Downloads/Downloads/Completed_Downloads/ | grep "$FILM" | wc -l)

if [ $CHECK_DIR = "0" ]; then
  echo "All $FILM folders successfully moved to $DIR"
  echo
else
  echo "Data transfer failed, please run again..."
  echo
  exit 1
fi

}

##########################
### script starts here ###
##########################

read -p "Enter the Film quality: " FILM
case $FILM in
  720p|1080p|3D|4K)

    #Directory to move directories/files to
    DIR="/media/Films/Films/Blu-ray/$FILM/"
    DIR4K="/media/4K/4K/4K_Films/"

    if [ $FILM = "4K" ];then
      DIR=$DIR4K
    fi

    echo
    echo "All folders with ($FILM) in the name will now be moved from $SRC_DIR to $DIR"

    echo
    echo "Moving..."
    echo

    mv $SRC_DIR/*\($FILM\)* $DIR

    postMoveCheck

    exit 0
    ;;

  *)
    echo "Incorrect Film quality entered, nothing has been moved"
    ;;
  esac
