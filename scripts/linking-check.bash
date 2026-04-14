#!/bin/bash
# Sometimes we can't compile a program/dynamic library on the same system where
# it's to run. Thus, we might cross compile, or in rare cases, pull the binary
# from some source. 
#
# On GNU/Linux, where dynamic linking is dominant, version and ABI matches are
# important for this case. This simple script checks all dynamic libs needed by
# an ELF, and consults with the system's ldconfig to see if their versions
# match.

set -euo pipefail

TARGET="$1"

if [[ ! -f "$TARGET" ]]; then
	echo "Error: target file not found: $TARGET"
	echo "Usage: $0 target"
	exit 1
fi

echo "== Extracting NEEDED entries from $TARGET =="

# Extract SONAMEs
mapfile -t NEEDED < <(readelf -d "$TARGET" \
	| grep NEEDED \
	| sed -E 's/.*\[(.*)\]/\1/')

printf "%s\n" "${NEEDED[@]}"

echo
echo "== Caching ldconfig output =="

LDCONFIG_CACHE=$(mktemp)
trap 'rm -f "$LDCONFIG_CACHE"' EXIT

/sbin/ldconfig -p > "$LDCONFIG_CACHE"

echo "Cached $(wc -l < "$LDCONFIG_CACHE") entries"
echo

echo "== Checking resolution =="

for lib in "${NEEDED[@]}"; do
	echo "Checking: $lib"

	# exact SONAME match
	MATCHES=$(grep -F "$lib" "$LDCONFIG_CACHE" || true)

	if [[ -z "$MATCHES" ]]; then
		echo "   NOT FOUND in ldconfig"
		continue
	fi

	echo "   Found candidates:"
	echo "$MATCHES" | sed 's/^/	/'

	# Extract base name (.so from .so.xxx)
	base=$(echo "$lib" | sed -E 's/\.so(\..*)?/.so/')

	ALT_MATCHES=$(grep -F "$base" "$LDCONFIG_CACHE" || true)

	if [[ "$ALT_MATCHES" != "$MATCHES" ]]; then
		echo "	All versions available:"
		echo "$ALT_MATCHES" | sed 's/^/	/'
	fi

	echo
done

echo "== Done =="
