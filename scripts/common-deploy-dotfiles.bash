#
# Common functions used by clone-gitrepos.bash only.
# 
# MUST BE SOURCED AFTER THE VARS ARE DEFINES:
# TOPICS, BASE_URIS, DEST, AND CWD.

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

main() {
	for (( i=0 ; i < ${#DIRS[@]} ; i=$(($i+1)) )); do
		dir=${DIRS[$i]}
		[[ -d ${HOME}/${dir} ]] || mkdir ${dir}
		declare -n files=DOTFILES_$i

		for f in "${files[@]}"; do 
			install_file ${dir} $f || echo "Could not install $f to ${dir}"
		done
	done
}
