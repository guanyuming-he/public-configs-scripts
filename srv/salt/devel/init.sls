{% set devel_roles = grains.get('devel', []) %}


include:
  # Basic devel needs:
  - devel.devel_basic
  - devel.git
{% if 'c' in devel_roles or 'cpp' in devel_roles or 'c++' in devel_roles %}
  - devel.c++
{% endif %}
{% if 'go' in devel_roles %}
  - devel.go
{% endif %}
{% if 'java' in devel_roles %}
  - devel.java
{% endif %}
{% if 'python' in devel_roles %}
  - devel.python
{% endif %}
{% if 'rust' in devel_roles %}
  - devel.rust
{% endif %}
{% if 'texlive' in devel_roles %}
  - devel.texlive
{% endif %}
