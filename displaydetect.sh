#!/bin/bash
### BEGIN INIT INFO
# Provides: DisplayDetect
#Required-Start:
#Required-Stop:
#Default-Start:
# 2 3 4 5
#Default-Stop: 1 0 6
#Short-Description: ...
#Description: ...
### END INIT INFO

##########################################################################
# This Script automizes the process of choosing the right output for the #
# raspbarry pi 4.  # It always boots in HDMI and checks if a display is  #
# present otherwise it switches to # Composite.                          #
#									 #
# Place this script in /etc/init.d and let it run on boot. make sure     #
# your /boot/config.txt # has a line that starts with 			 #
# "enable_tvout=1"(no whitespace)					 #
##########################################################################

# this is the config.txt parameter you want to change
MYTHING="enable_tvout"

# store the output of the tvservice monitor name
TVN=$(/opt/vc/bin/tvservice -n)

# if the above command matches the HDMI display detected pattern
if [ $(echo "$TVN" | egrep -c "device_name") -gt 0 -a $(echo "$TVN" | egrep -c "device_name=Unk-Composite dis") -eq 0 ]
then
    # we're plugged into HDMI
    OUTPUT="hdmi"
else
    # we're plugged into Composite
    OUTPUT="comp"
fi

# when plugged into HDMI, run this
if [ "$OUTPUT" == "hdmi" ]
then
    # if a line starts "my_parameter" without a comment
    if [ $(egrep -c "^enable_tvout" /boot/config.txt) -gt 0 ]
    then
        # comment out the parameter and reboot
        sudo sed -i -e "s/^$MYTHING/#$MYTHING/g" /boot/config.txt
	reboot
    fi
fi

# when plugged into Composite, run this
if [ "$OUTPUT" == "comp" ]
then
    # if we're sending out a composite signal, comment out parameter.
	if [ $(echo "$TVN" | egrep -c "device_name=Unk-Composite dis") -gt 0 ]
	then
    	sudo sed -i -e "s/^$MYTHING/#$MYTHING/g" /boot/config.txt
	else
        # if we're sending out HDMI but no display is connected, uncomment the parameter and reboot
        sudo sed -i -e "s/^#$MYTHING/$MYTHING/g" /boot/config.txt
	reboot
	fi
fi
