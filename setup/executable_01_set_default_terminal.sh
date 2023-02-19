#!/bin/env bash

# Set new default (kitty)
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $HOME/bin/nvim 1
sudo update-alternatives --config x-terminal-emulator
