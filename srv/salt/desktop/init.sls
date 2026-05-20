# Desktop and their apps

{% from desktop/map.jinja import desktop %}

include:
  - desktop.basic_apps
  - desktop.document_apps
  - desktop.graphics_apps

{% if desktop == 'xfce' %}
  - desktop.xfce
#{% elif desktop == 'kde' %}
#  - desktop.kde
#{% elif desktop == 'mate' %}
#  - desktop.mate
#{% elif desktop == 'gnome' %}
#  - desktop.gnome
{% endif %}

