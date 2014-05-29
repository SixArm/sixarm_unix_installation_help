#!/bin/bash
#
# Install the current Ruby MRI by using ruby-build.
# We put ruby in /opt/ruby/x.y.z and link it to /opt/ruby/current.
#
sudo su -
mkdir -p /opt/ruby
ruby-build --definitions | grep "^[0-9]\+\.[0-9]\+\.[0-9]\+$" | tail -1 | xargs -I{} ruby-build --verbose {} /opt/ruby/{}
cd /opt/ruby
ln -t1 | head -1 | xargs -I{} ln -s "{}" current
