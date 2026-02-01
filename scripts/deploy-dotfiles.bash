#!/bin/bash

# Dotfiles are installed to dirs by creating links between them.
# Symlinks may not work for some programs which refuse to read symlink configs
# (probably for security reasons)
# This script must be executed inside the dir it resides in.
#
# Each dir will have a list of dot files to install to.

set -u

###############################################################################
# Variables 
###############################################################################

readonly -a DIRS=(
	.
	.bashrc.d
	.config/vifm
)

readonly -a DOTFILES_0=(
	.bashrc
	.bash_aliases
	.vimrc
)
readonly -a DOTFILES_1=(
	10findsrc.bash	
	10prompt.bash	
	10texlive.bash	
)
readonly -a DOTFILES_2=(
	vifmrc
)

###############################################################################
# Functions
###############################################################################

# $1: dir $2: file name
install_file() {
	if ! ( [[ $1 ]] && [[ $2 ]] ); then 
		echo "can't install empty file or dir"
		return 1
	fi

	local src=../dotfiles/$1/$2
	if ! [[ -f ${src} ]]; then
		echo "src dot file does not exist!!"
		return 1
	fi

	local dest=${HOME}/$1/$2
	if [[ -f ${dest} ]]; then
		rm ${dest}
	fi

	ln ${src} ${dest} && echo "installed $2 to ${HOME}/$1"
	return
}

###############################################################################
# Main
###############################################################################

for (( i=0 ; i < ${#DIRS[@]} ; i=$(($i+1)) )); do
	dir=${DIRS[$i]}
	[[ -d ${HOME}/${dir} ]] || mkdir ${dir}
	declare -n files=DOTFILES_$i

	for f in "${files[@]}"; do 
		install_file ${dir} $f || echo "Could not install $f to ${dir}"
	done
done

