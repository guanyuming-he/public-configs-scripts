# The bash.sls installs bash packages and configures bash.

{% from "map.jinja" import user, home %}

bash_pkg:
  pkg.installed:
    - pkgs:
      - bash

bash_rc:
  file.managed:
    - name: {{home}}/.bashrc
    - source: salt://shell/files/.bashrc
    - user: {{user}}
    - group: {{user}}
    - mode: 600

bash_aliases:
  file.managed:
    - name: {{home}}/.bash_aliases
    - source: salt://shell/files/.bash_aliases
    - user: {{user}}
    - group: {{user}}
    - mode: 600

bash_rc_dir:
  file.recurse:
    - name: {{home}}/.bashrc.d
    - source: salt://shell/files/.bashrc.d
    - user: {{user}}
    - group: {{user}}
    - dir_mode: 700
    - file_mode: 600
    - makedirs: True
    - clean: False
