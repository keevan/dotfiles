#/usr/bin/bash

# Install atom (editor) - if not already installed
snap install atom --classic

# Install packages used
# TODO: Install list of packages defined in the state

apm install --packages-file ~/.atom/package-list.txt
