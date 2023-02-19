#!/bin/env bash

# Inkscape
sudo add-apt-repository universe
sudo add-apt-repository ppa:inkscape.dev/stable

# Gimp
sudo add-apt-repository ppa:ubuntuhandbook1/gimp

# Install
sudo apt update
sudo apt install gimp inkscape
