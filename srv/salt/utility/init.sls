# /srv/salt/utility/init.sls

{% from map.jinja import pkg with context %}

utility_packages:
  pkg.installed:
    - pkgs:

      # Shell utilities
      - bash-completion
      - less
      - tree
      - which

      # Storage
      - cryptsetup
      - gzip
      - rsync
      - tar
      - unzip
      - xz
      - {{ pkg['7zip'] }}

      # Networking
      - curl
      - nmap
      - socat
      - tcpdump
      - wget
      - {{ pkg['dnsutils'] }}
      - {{ pkg['openssh-client'] }}

      # System inspection
      - lsof
      - nvme-cli
      - pciutils
      - smartmontools
      - usbutils


