#!/bin/bash
#
# Common functions used by clone-gitrepos.bash only.
# 
# MUST BE SOURCED AFTER THE VARS ARE DEFINES:
# TOPICS, BASE_URIS, DEST, AND CWD.

# Can load local ssh identity via ssh-add -l 
# or fido identity via ssh-add -K
# Before that, will clean with ssh-agent -k
# and start anew with ssh-agent -s
setup_ssh_auth() {
	if [[ -v SSH_AGENT_PID && ${SSH_AGENT_PID} ]]; then
		echo "Resetting ssh"
		eval $(ssh-agent -k)
	fi

	eval $(ssh-agent -s)

	echo "Where is the ssh identity?"
	while true; do
		echo "1) file"
		echo "2) FIDO hardware"
		local id
		read -p "[1-2]:" id
		case ${id} in 
			1)
				local file
				read -p "input file path:" file
				file=$(realpath ${file})
				if ! [[ -f ${file} ]]; then
					echo "${file} does not exist"
					continue
				fi
				if ! ssh-add ${file}; then 
					echo "could not add ssh id";
					ask_yn "try again?" || return 1
				else
					return 0
				fi
			;;
			2)
				if ! ssh-add -K; then
					echo "Could not read from FIDO."
					ask_yn "try again?" || return 1
				else
					return 0
				fi
			;;
			*) echo "bad option" ;;
		esac
	done
}

# $1 topic dir $2 repo name $3 topic
# Clone the repo if not found
# otherwise update it
clone_or_update() {
	# trim topic name from r,
	# if r starts with ${topic}-
	# E.g. qubes-doc -> doc
	trimmed="${2#${3}-}"
	dest=$1/${trimmed}
	if [[ ! ${dest} ]]; then 
		echo "Empty path to dir not allowed!"; return 1
	fi

	if [[ -d ${dest}/.git ]]; then
		echo "Repo exists. How to update?"
		cd ${dest}
		while true; do
			echo "1) git fetch origin"
			echo "2) git pull origin main"
			echo "3) Do not update."
			read -p "[1-3]:" upd
			case ${upd} in 
				1) git fetch origin; break ;;
				2) git pull origin main; break ;;
				3) break ;;
				*) echo "Invalid option" ;;
			esac
		done

		cd ${CWD}
		return 0
	fi

	(
		set -x # show what's executed
		cd $1
		mkdir -p ${trimmed}
		git clone ${BASE_URIS[$3]}/$2.git ${trimmed}
		cd ${CWD}
	)
}

main() {
	mkdir -p ${DEST}

	for t in "${TOPICS[@]}"; do
		ask_yn "Do you want topic $t?" || continue

		case ${BASE_URIS[$t]} in
			ssh://*|git@github*) setup_ssh_auth ;;
			https://*) echo "using HTTPS" ;;
			http://*) 
				ask_yn "Using HTTP (unsafe). Sure?" || continue
			;;
			*) echo "Unsupported base URI"; continue ;;
		esac
		
		topic_dir=${DEST}/$t
		mkdir -p ${topic_dir}

		# -n declares an alias to the name assigned to it.
		declare -n repos=REPOS_$t
		declare -a selected=()

		for r in "${repos[@]}"; do
			ask_yn "Clone $r?" && selected+=($r)
		done
		read -p "Additional repos? (separated by space):" addi
		for a in ${addi}; do
			selected+=($a)
		done

		for r in ${selected[@]}; do
			clone_or_update ${topic_dir} $r $t
		done
	done
}
