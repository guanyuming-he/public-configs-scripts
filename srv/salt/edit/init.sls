{% set editor = grains.get('editor', []) %}

include:
{% if 'vim' in editor %}
  - edit.vim
{% endif %}
{% if 'emacs' in editor %}
  - edit.emacs
{% endif %}
