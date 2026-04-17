#!/bin/bash

# Sets up (as many as I need) virtual env for Python, each of which
# 1. is setup by python3 -m venv ~/py-<name>
# 2. installs some minimal mutual packages
# 3. reads a requirements.txt and install all packages there.

. ./common-setup-py-venvs.bash

read -r -a pip_args -p "please input additional pip args: "

while true; do
	read -p "please input venv name: " name
	read -ep "please input requirements.txt path: " rpath

	setup_venv "$name" "$rpath" "${pip_args[@]}"

	if ! ask_yn "setup another? (yes/no)"; then
		break
	fi
done

