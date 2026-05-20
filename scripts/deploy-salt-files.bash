# Securely deploy the ../srv to /srv, chowned as root:root.
# If I cp + chown, then there's a window in between where the dest files can be
# overridden by the previous owner user.
#
# Thus, I first create temp dir as root:root 0700, cp to it,
# chown within, and then mv to dest.

. ./common.bash

secure_deploy_root_dir ../srv/ /srv
