{% from "map.jinja" import user, home %}

launch_or_focus_script:
  file.managed:
    - name: {{home}}/bin/xfce/launch-or-focus.bash
    - source: salt://desktop/files/scripts/launch-or-focus.sh
    - user: {{user}}
    - group: {{user}}
    - mode: '0700'
    - dir_mode: '0700'
    - makedirs: True

setup_xfce:
  cmd.script:
    - source: salt://desktop/files/scripts/xfce-setup.sh
    - shell: /bin/bash
    - runas: {{user}}
