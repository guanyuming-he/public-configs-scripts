# Installs python, pip, venv, and creates a few venvs.

{% from "map.jinja" import pkg with context %}

python_pkgs:
  pkg.installed:
    - pkgs:
      - {{ pkg['python_pip'] }}
      - {{ pkg['python_venv'] }}


