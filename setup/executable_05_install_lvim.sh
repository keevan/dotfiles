#!/usr/bin/env bash

# Install rust & cargo
curl https://sh.rustup.rs -sSf | sh

bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
