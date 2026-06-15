# The nvim.sls installs neovim packages and configures nvim.

{% from "map.jinja" import user, home %}

nvim_pkgs:
  pkg.installed:
    - pkgs:
      - nvim
    # In case of a local installation
    - unless: 'su -l {{user}} -c "command -v nvim >/dev/null 2>&1"'

nvim_dir:
  file.recurse:
    - name: {{home}}/.config/nvim
    - source: salt://edit/files/nvim
    - user: {{user}}
    - group: {{user}}
    - dir_mode: 700
    - file_mode: 600
    - makedirs: True

nvim_lspconfig:
  git.latest:
    - name: https://github.com/neovim/nvim-lspconfig
    - target: {{home}}/.config/nvim/pack/nvim/start/nvim-lspconfig
    - require:
      - file: nvim_dir
    - user: {{user}}
