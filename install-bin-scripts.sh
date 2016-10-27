#!/bin/sh

# Copyright (C) 2016 Assaf Gordon <assafgordon@gmail.com>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


#
# A tiny bootstrap script to download and install gordon's bin_scripts.
# Typical usage:
#    sudo apt-get install automake autoconf make git
#    curl https://housegordon.org/install-bin-scripts.sh | sh
#
# See: https://github.com/agordon/bin_scripts for details.

set -eu
dir=$(mktemp -d -t agn-bin-scripts.XXXXXX)
cd "$dir"

git clone git://github.com/agordon/bin_scripts.git
cd bin_scripts
./bootstrap
./configure
make

sudo -p "Enter password(sudo) for bin_script's 'make install': " make install

cd $(dirname "$dir")
rm -rf "$dir/"
