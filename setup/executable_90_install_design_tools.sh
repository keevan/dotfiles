#!/bin/env bash

# Inkscape
sudo add-apt-repository --yes universe
sudo add-apt-repository --yes ppa:inkscape.dev/stable

# Gimp
sudo add-apt-repository --yes ppa:ubuntuhandbook1/gimp

# Install
sudo apt update
sudo apt install gimp inkscape
