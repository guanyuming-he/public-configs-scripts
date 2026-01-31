# /usr/share/doc is the conventional place for doc storage. However, it's
# pretty tedious to install all doc there, and it's also tedious to have to
# type the path to any doc there each time I want to read a doc.
#
# Hence, I write this make file which
# - is intended to be installed to /usr/share/doc and executed by alias
#   make-doc='make -f /usr/share/doc/Makefile', and provides a rule
#   'self' to do it.
# - for each pkg, records its doc download URI, doc filename
# - provides rule init-store, which creates its working dir ~/.doc-mk-work.
#   There's no reason to keep the downloaded files permanent by default, as
#   they are to be installed after downloading. If one wants to make them
#   persistent, consider copying them out directly. 
# - provides rule <pkg>-dl, which downloads from URI to doc filename inside
#   working dir
# - provides rule <pkg>-install, which installs doc filename from working dir
#   to /usr/share/doc/relative-path
# - provides rule <pkg>-read, which tries to xdg-open doc filename from
#   /usr/share/doc/relative-path
# - provides rule dl-all and install-all which performs <pkg>-dl and
#   <pkg>-install for all known pkgs, respectively.

######################################################################
# Vars and functions
######################################################################

THIS_MAKEFILE := $(lastword $(MAKEFILE_LIST))
WORK_DIR := $(HOME)/.doc-mk-work
DOC_DIR := /usr/share/doc

# Allows users to pass dl options
DL ?= curl -L
PROXY ?= socks5h://127.0.0.1:6789

# Pkg records
gcc		:= https://gcc.gnu.org/onlinedocs/gcc-15.2.0/gcc.pdf gcc.pdf
gdb		:= https://sourceware.org/gdb/current/onlinedocs/gdb.pdf gdb.pdf
gpg		:= https://www.gnupg.org/documentation/manuals/gnupg.pdf gnupg.pdf
make	:= https://www.gnu.org/software/make/manual/make.html make.html

PKGS := gcc gdb gpg make

# Pkg record functions
uri_of = $(word 1, $($1))
fname_of = $(word 2, $($1))

######################################################################
# Rules (pkg related)
######################################################################

# Pkg install function
install_cmd_of = \
	mkdir -p $(DOC_DIR)/$1; \
	install -o root -g root -m 0644 \
		$(WORK_DIR)/$(call fname_of,$1) \
		$(DOC_DIR)/$1/$(call fname_of,$1)

# Install self; always updates.
.PHONY: self
self : 
	su -c "install -o root -g root -m 0644 $(THIS_MAKEFILE) \
		$(DOC_DIR)/Makefile"

# mk work dir
$(WORK_DIR) :
	mkdir -p $(WORK_DIR)
.PHONY: init-store
init-store : $(WORK_DIR)

# Pkg rules
define PKG_RULES

$(WORK_DIR)/$(call fname_of,$1) : | $(WORK_DIR)
	$(DL) $(if $(PROXY),--proxy $(PROXY)) \
		$(call uri_of,$1) \
		-o $(WORK_DIR)/$(call fname_of,$1)

$1-dl : $(WORK_DIR)/$(call fname_of,$1)
$(DOC_DIR)/$1/$(call fname_of,$1) : $(WORK_DIR)/$(call fname_of,$1)
	su -c "$(call install_cmd_of,$1)"

$1-install : $(DOC_DIR)/$1/$(call fname_of,$1)

$1-read : $(DOC_DIR)/$1/$(call fname_of,$1)
	xdg-open $(DOC_DIR)/$1/$(call fname_of,$1)

.PHONY: $1-dl $1-install $1-read

endef

$(foreach p,$(PKGS),$(eval $(call PKG_RULES,$(p))))

.PHONY: dl-all install-all
dl-all : 
	$(MAKE) -f $(THIS_MAKEFILE) $(PKGS:%=%-dl)
# For the sake of never downloading as root, execute dl-all first
install-all : dl-all
	su -c "$(foreach p,$(PKGS),$(call install_cmd_of,$1);)"

