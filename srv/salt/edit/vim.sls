# The vim.sls installs vim packages and configures vim.

{% from "map.jinja" import user, home %}

vim_pkgs:
  pkg.installed:
    - pkgs:
      - vim
      - vim-gtk3

vim_dir:
  file.recurse:
    - name: {{home}}/.vim
    - source: salt://edit/files/.vim
    - user: {{user}}
    - group: {{user}}
    - dir_mode: 700
    - file_mode: 600
    - makedirs: True

vim_autoload_dir:
  file.directory:
    - name: {{home}}/.vim/autoload
    - user: {{user}}
    - group: {{user}}
    - mode: 700
    - makedirs: True

vim_plug:
  file.managed:
    - name: {{home}}/.vim/autoload/plug.vim
    # Release 0.14.0
    - source: https://raw.githubusercontent.com/junegunn/vim-plug/d80f495fabff8446972b8695ba251ca636a047b0/plug.vim
    - user: {{user}}
    - group: {{user}}
    - mode: 600
    # sha512sum
    - source_hash: 0927fe51213ab3e8764f9f42c744bf92d3e90c4cbdbba834cd07cf900a0740f0c626bb8e038fb2b91c148063856d80a006f2f8b01ec8bda0efd734f462f22332
    - require:
      - file: vim_autoload_dir

root_vim_rc:
  file.managed:
    - name: /root/.vimrc
    - source: salt://edit/files/root_vimrc
    - user: root
    - group: root
    - mode: 600

