#!/bin/bash

##################################################################################
################ Move folders or files to a new location #########################
###################### written by Phil Walker ####################################
##################################################################################

#!/bin/bash

#amend variable assignments for source and destination folders - example below is to move all folders containing (2016) in the name to a new location
#specific file types could also be moved or all contents of the source folder

########################################################
#Variables#
#Directory to move directories/files from
Src="/path/to/source/folder"

#Directory to move directories/files to
Dst="/path/to/destination/folder"
#######################################################

echo "All folders with (2016) in the name will now be moved from $Src to $Dst"

echo
echo "Moving..."
echo

mv $Src/*\(2016\) $Dst

echo "All folders successfully moved to $Dst"
echo

exit 0
