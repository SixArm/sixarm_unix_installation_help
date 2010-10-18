#!/bin/bash
#
# Fresh unix install for Joel

# Assert 
mkdir -p /home/sources/downloads/

## Get many git repos
mkdir -p /home/sources/git/
cd /home/sources/git/ && cat ~sixarm/github/unix/install/git_projects.txt | perl -p -e 'system("git clone $_")'

## Emacs starter kit
mkdir -p /usr/local/share/emacs/site-lisp/snippets
mkdir ~/.emacs.d
mkdir ~/.emacs.d/plugins
cp -R /home/sources/git/emacs-starter-kit/* ~/.emacs.d/
