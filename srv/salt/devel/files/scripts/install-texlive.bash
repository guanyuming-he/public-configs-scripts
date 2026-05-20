#!/bin/bash

set -euo pipefail

if ![[ -f ./texlive-profile ]]; then
	echo "No profile." &>2
	exit 1
fi

curl --fail --retry 3 -LO \
https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
curl --fail --retry 3 -LO \
https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512
curl --fail --retry 3 -LO \
https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz.sha512.asc

gpg --verify ./install-tl-unx.tar.gz.sha512.asc
sha512sum -c ./install-tl-unx.tar.gz.sha512
tar -xzf ./install-tl-unx.tar.gz
# The untared dir will be in the name install-tl-<year><mm><dd>
cd ./install-tl-20* &&
	perl ./install-tl -profile ./texlive-profile
