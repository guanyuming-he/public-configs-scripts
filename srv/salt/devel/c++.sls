# For C/C++ devel
{% from 'map.jinja' import pkg with context %}

# Since most are covered in devel_basic.sls
# here I just include auxiliary packages, e.g., for LSP.
cpp_pkgs:
  pkg.installed:
    - pkgs:
      - bear # turns make into compile_commands.json
      - clangd
