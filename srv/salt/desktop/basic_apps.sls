# Basic desktop applications to install

{% from map.jinja import pkg with context %}

desktop_basic_apps:
  pkg.installed:
    - pkgs:
      - {{ pkg['firefox'] }}
      - thunderbird
      - keepassxc
      - vlc
