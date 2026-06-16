# The git.sls installs git and configures it.

{% from "map.jinja" import user, home %}

git_pkgs:
  pkg.installed:
    - pkgs:
      - git

#git_config:
#  file.managed:
#    - name: {{home}}/.gitconfig
#    - source: salt://devel/files/git/.gitconfig
#    - user: {{user}}
#    - group: {{user}}
#    - mode: 600

git_ignore:
  file.managed:
    - name: {{home}}/.gitignore
    - source: salt://devel/files/git/.gitignore
    - user: {{user}}
    - group: {{user}}
    - mode: 600

{{home}}/Documents/git_repos:
  file.directory:
    - user: {{user}}
    - group: {{user}}
    - mode: 755
    - makedirs: True
