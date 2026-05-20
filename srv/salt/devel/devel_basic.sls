# The devel-basic.sls defines packages and configs for basic development on GNU/Linux,
# including basic C/C++ devel tools, as well as auxiliry tools such us GNU binutils.

{% from map.jinja import pkg with context %}

devel_basic_pkgs:
  pkg.installed:
    - pkgs:
      # bundled utils
      - binutils
      - coreutils
      # GNU autotools build system
      - automake
      - autoconf
      # make
      - make
      # CMake build system
      - cmake
      # compilers
      - gcc
      - {{ pkg['g++'] }}
      # version mgmt
      - git
      # auxiliary GNU packages
      - bison
      - flex
      - gettext
      # lib tools
      - libtool 
      - {{ pkg['pkgconf'] }}
      # debugger
      - gdb
      # tracing
      - strace
      - ltrace
      

