#!/bin/bash

# common functions for setup-py-venvs

. ./common.bash

usage() {
	error "Usage: $0 <name> <requirements.txt> [pip args...]"
}

# executed by all venv before installing requirements.txt
mutual_actions() {
	# for pip over socks proxy
	python3 -m pip install pysocks
}

# $1 venv name
# $2 path to requirements.txt
# $3+ additional args to pass to pip when installing requirements
setup_venv() {
	if [[ $# -lt 2 ]]; then
		usage
		return 1
	fi

	local name="$1"
	local req="$(realpath $2)"
	shift 2
	local extra_args=("$@")
	local venv_path="$HOME/py-$name"

	# Name validation
	if ! [[ "$name" =~ ^[a-zA-Z0-9_-]+$ ]]; then
		error "Venv name can only contain letters, numbers, _ or -"
		return 1
	fi

	# Venv existence check
	if [[ -d "$venv_path" ]]; then
		if ask_yn "Venv '$venv_path' exists. Overwrite? (yes/no): "; then
			rm -rf "$venv_path"
		else
		   	echo "Skipping venv creation"; return 0
		fi
	fi

	echo "Creating virtual environment at $venv_path"
	python3 -m venv "$venv_path"

	. "$venv_path/bin/activate"

	mutual_actions "$venv_path"

	if  [[ -r "$req" ]]; then
		echo "Installing requirements from $req"
		python3 -m pip install "${extra_args[@]}" -r "$req"
	else
		echo "Requirements file '$req' is not readable, will skip."
	fi

	deactivate

	echo "Venv '$name' is set up completely."
}
