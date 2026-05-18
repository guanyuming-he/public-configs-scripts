# The vim.sls installs vim packages and configures vim.

devel_basic_pkgs:
  pkg.installed:
    - pkgs:
      - vim
      - vim-gtk3
