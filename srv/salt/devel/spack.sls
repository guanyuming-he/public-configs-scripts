{% from 'map.jinja' import pkg with context %}
{% from 'map.jinja' import user, home %}

include:
  - devel.git

spack:
  git.latest:
    - name: https://github.com/spack/spack
    - target: {{home}}/Documents/git_repos/spack
    - user: {{user}}
    - rev: v1.1.1
    - require:
      - sls: devel.git

spack_files:
  file.recurse:
    - name: {{home}}/.spack
    - source: salt://devel/files/spack
    - user: {{user}}
    - group: {{user}}
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
