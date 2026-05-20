#!/bin/bash
# Xfce's keybindings are somewhat old and do not confrom to my habits.
# Thus, this script will populate the settings that I'd like to use
# with xfconf-query.

xfwm="/xfwm4/custom"
cmds="/commands/custom"
# See bash doc Arrays 
actions=(
	maximize_window_key
	hide_window_key            	
	tile_left_key
	tile_right_key
	tile_up_right_key
	"${HOME}/bin/xfce/launch-or-focus.sh firefox-esr firefox-esr"
	xfce4-screenshooter
	xflock4
)
oldkeys=(
	"${xfwm}/<Alt>F9"				
	"${xfwm}/<Alt>F10"			
	"${xfwm}/<Super>KP_Left"		
	"${xfwm}/<Super>KP_Right"		
	"${xfwm}/<Super>KP_Page_Up"	
	"${cmds}/<Super>1"	
	"${cmds}/Print"	
	"${cmds}/<Primary><Alt>l"	
)
newkeys=(
	"${xfwm}/<Super>Up"				
	"${xfwm}/<Super>Down"			
	"${xfwm}/<Super>Left"		
	"${xfwm}/<Super>Right"		
	"${xfwm}/<Super>Page_Up"	
	"${cmds}/<Super>1"	
	"${cmds}/<Primary><Shift>S"	
	"${cmds}/<Super>l"	
)

##############################################################################
# rm old keys (there is no rm, but only -r reset in xfconf-query).
# When it acts on a .../custom/... key, it seems to perform the reset
# by removing it so that the system falls back to the corresponding
# .../default/...
for (( i=0 ; $i < ${#actions[*]} ; i=$(($i+1)) )); do
	key=${oldkeys[$i]}
	xfconf-query -c xfce4-keyboard-shortcuts -p "${key}" -r;
done

##############################################################################
# populate new keys
# /xfwm4/custom
for (( i=0 ; $i < ${#actions[*]} ; i=$(($i+1)) )); do
	key=${newkeys[$i]}
	val=${actions[$i]}
	xfconf-query -c xfce4-keyboard-shortcuts -p "${key}" \
		-n -t string -s "${val}";
done

# update
xfwm4 --replace &>/dev/null &
