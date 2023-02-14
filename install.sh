#!/bin/sh

# Install git.

# cd to home dir
cd ~

# Installing dot files with a single link
curl -sfL https://git.io/chezmoi | sh

# Ensure chezmoi is "available"
. .profile
hash -r

cd -

# Init personal dotfiles - which also applies the configs
chezmoi init https://github.com/keevan/dotfiles

# Apply the changes
chezmoi apply
