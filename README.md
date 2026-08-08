The part of my configs and scripts which does not expose private information
about me is better left public, for two reasons. 
1. They can help others 
2. I can access it without logging to my github, in public working computers. 

Currently, most system-level configs are managed via Salt, and most local
packages are managed via Spack, which is simply installed by cloning its git
repo, so I did not put it in Salt (will need to constantly checkout to its
latest tag). As a consequence, spack configs are in ./dotfiles, instead of
./srv/salt.
