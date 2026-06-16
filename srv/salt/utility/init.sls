# /srv/salt/utility/init.sls

{% from 'map.jinja' import pkg with context %}

utility_packages:
  pkg.installed:
    - pkgs:

      # Shell utilities
      - bash-completion
      - less
      - tree

      # Storage
      - cryptsetup
      - gzip
      - rsync
      - tar
      - unzip
      - {{ pkg['7zip'] }}

      # Networking
      - curl
      - nmap
      - socat
      - tcpdump
      - wget
      - {{ pkg['dnsutils'] }}
      - {{ pkg['openssh_client'] }}

      # System inspection
      - lsof
      - nvme-cli
      - pciutils
      - smartmontools
      - usbutils

      # Basic math
      - bc


