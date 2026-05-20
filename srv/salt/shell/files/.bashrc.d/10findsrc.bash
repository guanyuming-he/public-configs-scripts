# Gives a list of all source files
# Args: prog lang names.
findsrc() {
	if [[ $# < 1 ]]; then return 1; fi

	local -a exts=()
	for lang in "$@"; do
		case $lang in
			bash) exts+=(sh bash) ;;
			c) exts+=(c h) ;;
			coq|rocq) exts+=(v) ;;
			c++|cpp) exts+=(c h cc hh cpp hpp) ;;
			go) exts+=(go) ;;
			java) exts+=(java) ;;
			ml|ocaml) exts+=(ml mli) ;;
			py|python) exts+=(py pyw) ;;
			rs|rust) exts+=(rs) ;;
			sh) exts+=(sh) ;;
			*) 
				echo "$lang is not supported."
				return 1
			;;
		esac
	done

	# Deduplicate exts
	local uniq_exts=$(
		printf '%s\n' "${exts[@]}" | sort -u | paste -sd'|'
	)
	
	local regex=".*\\.(${uniq_exts})$"
	# For testing, uncomment echo and comment find
	# echo ${regex}
	find . -type f -regextype posix-extended -regex "${regex}"
}
