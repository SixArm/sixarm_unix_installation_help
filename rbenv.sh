#!/bin/bash
set -o errexit
set -o xtrace

[ -e ~/.rbenv ] || git clone git://github.com/sstephenson/rbenv.git ~/.rbenv

f=~/.bash_profile
s='export PATH="$HOME/.rbenv/bin:$PATH"' 
grep -F "$s" "$f" || echo "$s" >> "$f"
s='eval "$(rbenv init -)"'
grep -F "$s" "$f" || echo "$s" >> "$f"

