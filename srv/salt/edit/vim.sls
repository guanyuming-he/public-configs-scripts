# The vim.sls installs vim packages and configures vim.

{% from "edit/map.jinja" import edit %}

vim_pkgs:
  pkg.installed:
    - pkgs:
      - vim
      - vim-gtk3

vim_rc:
  file.managed:
    - name: {{home}}/.vimrc
    - source: salt://edit/files/.vimrc
    - user: {{user}}
    - group: {{user}}
    - mode: 640

vim_autoload_dir:
  file.directory:
    - name: {{home}}/.vim/autoload
    - user: {{user}}
    - group: {{user}}
    - mode: 750
    - makedirs: True

vim_plug:
  file.managed:
    - name: {{home}}/.vim/autoload/plug.vim
    - source: https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    - user: {{user}}
    - group: {{user}}
    - mode: 640
    - require:
      - file: vim_autoload_dir

root_vim_rc:
  file.managed:
    - name: /root/.vimrc
    - source: salt://edit/files/root_vimrc
    - user: root
    - group: root
    - mode: 640

