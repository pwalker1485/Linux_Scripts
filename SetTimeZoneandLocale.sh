#!/bin/bash

########################################################################
#               Set Time Zone and System Locale Settings               #
######################## written by Phil Walker ########################
########################################################################

# Amend variables to suit Time Zone & Locale required

########################################################################
#                            Variables                                 #
########################################################################

# Time Zone
timeZone="Europe/London"
# Locale 
localeChoice="en_GB.UTF-8"
# Language
localeLanguage="en_GB"

########################################################################
#                         Script starts here                           #
########################################################################

# Set the System Locale settings, if needed
# Results of changes cannot be checked until the next login session
if [[ $(locale | grep "LANG=" | cut -c 6-) != "$localeChoice" ]] || \
[[ $(locale | grep "LC_ALL=" | cut -c 8-) != "$localeChoice" ]] || \
[[ $(locale | grep "LANGUAGE=" | cut -c 10-) != "$localeLanguage" ]]; then
    echo "Changing the System Locale settings to $localeChoice..."
    locale-gen $localeChoice >/dev/null 2>&1 && \
    dpkg-reconfigure --frontend=noninteractive locales >/dev/null 2>&1 && \
    echo "LANG=$localeChoice" > /etc/default/locale && \
    update-locale LANG=$localeChoice && \
    update-locale LANGUAGE=$localeLanguage && \
    update-locale LC_ALL=$localeChoice
    echo "Logout required"
else
    echo "Current System Locale setting: $(locale | grep "LANG=" | cut -c 6-)"
    echo "System Locale settings already correct, nothing to do"
fi

# Set the Time Zone, if needed
if [[ $(cat /etc/timezone) != "$timeZone" ]]; then
    echo "Setting Time Zone to $timeZone"
    timedatectl set-timezone "$timeZone"
    # Check the change has been made successfully
    if [[ $(cat /etc/timezone) == "$timeZone" ]]; then
        echo "Time Zone now set to $timeZone"
    else
        echo "Failed to change Time Zone!"
        echo "Current Time Zone: $(cat /etc/timezone)"
        exit 1
    fi
else
    echo "Current Time Zone: $(cat /etc/timezone)"
    echo "Time Zone settings correct, nothing to do"
fi

exit 0