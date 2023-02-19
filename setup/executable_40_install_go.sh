#!/bin/env bash

# Uses https://github.com/keevan/go-installer (forked copy to prevent unknown changes)
# Doesn't download the script ~ runs the script directly
cd $HOME
mkdir -p tmp
cd tmp

if [[ ! -f go.sh ]]; then
  wget https://raw.githubusercontent.com/keevan/go-installer/master/go.sh
fi

export GOROOT=$HOME/bin/go      # install path
export GOPATH=$HOME/projects/go  # workspace

# Uninstall golang first
sudo rm -r $GOROOT

# Run it
chmod +x go.sh
bash -E ./go.sh

# Reload
source $HOME/.bashrc
source $HOME/.exports
