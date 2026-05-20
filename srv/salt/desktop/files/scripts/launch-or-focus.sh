#!/bin/bash
# The script performs the following logic which Xfce does not provide for the
# users:
# 1. Check if an application is running.
# 2. If not, launch it.
# 3. Otherwise, focus it. 

usage() {
	echo "$0 <wmclass> <command>"
	echo "you may find <wmclass> from the application's .desktop file"
	echo "<command> is as defined in bash."
	echo "you will need to install wmctrl for this"
}

# After the assignments, wmclass is the first word, and cmd is the rest"
wmclass="$1"
shift
cmd="$@"

if [[ "${wmclass}" == "--help" ]]; then
	usage
	exit 0;
fi

# xmctrl: -l list all windows -x include WM_CLASS inside list
# xmctrl: -a activate window WIN -x interpret WIN as WM_CLASS
# grep -q quiet; output 0 iff match found -i ignore case
if wmctrl -xl | grep -qi "${wmclass}"; then
	wmctrl -xa "${wmclass}"
else
	${cmd} &
fi
