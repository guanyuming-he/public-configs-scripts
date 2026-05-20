{% from "map.jinja" import user, home %}

gpg_dir:
  file.recurse:
    - name: {{home}}/.gnupg
    - source: salt://gpg/files/.gnupg
    - user: {{user}}
    - group: {{user}}
    - file_mode: '0600'
    - dir_mode: '0700'
    - makedirs: True
    # Makes salt merge instead of replacing the target dir.
    - clean: False

gpg_key_files:
  file.recurse:
    - name: {{home}}/.config/salt-gpg-public
    - source: salt://gpg/files/public
    - user: {{user}}
    - group: {{user}}
    - file_mode: '0600'
    - dir_mode: '0700'
    - makedirs: True

# import whenever pubkey changes.
gpg_import_public_keys:
  cmd.run:
    - name: |
        find {{home}}/.config/salt-gpg-public -type f -name '*.gpg' -print0 \
          | xargs -0 gpg --import
    - runas: {{user}}
    - env:
        - GNUPGHOME: {{home}}/.gnupg
    - onchanges:
      - file: gpg_key_files
