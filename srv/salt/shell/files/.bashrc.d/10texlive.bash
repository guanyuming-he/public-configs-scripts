# TeXLive to path if not already
if ! [[ ${PATH} == *texlive* ]]; then 
	sysTeX=$(echo /usr/local/texlive/20*)
	homTeX=$(echo ${HOME}/texlive/20*)

	# prefer home over sys
	if [[ -d ${homTeX} ]]; then
		export PATH="${homTeX}/bin/x86_64-linux:${PATH}"
		export MANPATH="${homTeX}/texmf-dist/doc/man:${MANPATH}"
		export INFOPATH="${homTeX}/texmf-dist/doc/info:${INFOPATH}"
	elif [[ -d ${sysTeX} ]]; then
		export PATH="${sysTeX}/bin/x86_64-linux:${PATH}"
		export MANPATH="${sysTeX}/texmf-dist/doc/man:${MANPATH}"
		export INFOPATH="${sysTeX}/texmf-dist/doc/info:${INFOPATH}"
	fi
fi
