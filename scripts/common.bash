#!/bin/bash
#
# Common functions used by other scripts

# param $1 prompt
# @returns 0 on yes
# 1 on no, and keeps asking if not one of them.
ask_yn() {
	local yn
	
	while true; do
		read -p "$1 [y/n]:" yn
		case ${yn} in
			y|Y|yes|Yes|YES) return 0 ;;
			n|N|no|No|NO) return 1 ;;
			*) ;;
		esac
	done
}


