#!/bin/bash
#
# Install the current Ruby MRI by using ruby-build
# and our preferred setup:
#
#   * Use /opt/ruby-build and git pull and install.sh to update it.
#   * Install ruby in /opt/ruby/x.y.z  and symlink /opt/ruby/current.

sudo su -
mkdir -p /opt/ruby
cd /opt/ruby-build && git pull && ./install.sh
ruby-build --definitions | grep "^[0-9]\+\.[0-9]\+\.[0-9]\+$" | tail -1 | xargs -I{} ruby-build --verbose {} /opt/ruby/{}
cd /opt/ruby
ln -t1 | head -1 | xargs -I{} ln -s "{}" current
