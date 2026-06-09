# This installs TeXLive using the installer.

{% from "map.jinja" import user, home %}

tl_working_dir:
  file.recurse:
    - name: {{home}}/.salt_working/texlive
    - source: salt://devel/files/texlive
    - user: {{user}}
    - group: {{user}}
    - dir_mode: 700
    - makedirs: True

# Needs gpg public key for texlive.
include:
  - gpg

install_tl:
 cmd.script:
  - source: salt://devel/files/scripts/install-texlive.bash
  - cwd: {{home}}/.salt_working/texlive
  - runas: {{user}}
  - shell: bash
  - creates: {{home}}/texlive
  # Unless tlmgr exists.
  - unless: 'su -l {{user}} -c "command -v tlmgr >/dev/null 2>&1"'
  - require:
    - file: tl_working_dir
    - sls: gpg
