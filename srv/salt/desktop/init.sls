# Desktop and their apps

{% from 'desktop/map.jinja' import desktop %}

{% set desktop_apps = grains.get('desktop', []) %}

include:
  - desktop.basic_apps
{% if 'document' in desktop_apps %}
  - desktop.document_apps
{% endif %}
{% if 'graphics' in desktop_apps %}
  - desktop.graphics_apps
{% endif %}

{% if desktop == 'xfce' %}
  - desktop.xfce
#{% elif desktop == 'kde' %}
#  - desktop.kde
#{% elif desktop == 'mate' %}
#  - desktop.mate
#{% elif desktop == 'gnome' %}
#  - desktop.gnome
{% endif %}

