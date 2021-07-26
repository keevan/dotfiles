#!/bin/sh

# Installing dot files with a single link
curl -sfL https://git.io/chezmoi | sh

# Init personal dotfiles - which also applies the configs
chezmoi init https://github.com/keevan/dotfiles
