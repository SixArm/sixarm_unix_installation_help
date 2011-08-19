#!/bin/sh
git clone --recursive git://github.com/fletcher/peg-multimarkdown.git
cd peg-multimarkdown
git submodule init
git submodule update --recursive
make test
make mmdtest
make latextest
cp multimarkdown /usr/local/bin/
cp scripts/mmd* /usr/local/bin/

