#/usr/bin/bash

# Install atom (editor) - if not already installed
# Snap version is old. Direct install from atom/atom releases is preferred
snap install atom --classic

# Install packages used
# TODO: Install list of packages defined in the state

# Below no longer works after atom sunset..
apm install --packages-file ~/.atom/package-list.txt
