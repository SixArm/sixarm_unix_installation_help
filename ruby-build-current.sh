#!/bin/bash
#
# Install the current Ruby MRI by using ruby-build
# and our preferred setup:
#
#   * Use /opt/ruby-build and git pull and install.sh to update it.
#   * Install ruby in /opt/ruby/x.y.z  and symlink /opt/ruby/current.

sudo su -

# Update ruby definitions
cd /opt/ruby-build &&
git pull &&
./install.sh

# Get the current MRI version,such as X.Y.Z
VERSION=`ruby-build --definitions | grep "^[0-9]\+\.[0-9]\+\.[0-9]\+$" | tail -1`

# Build it
RUBY_DIR=/opt/ruby
ruby-build --verbose $VERSION $RUBY_DIR/$VERSION && 
cd $RUBY_DIR &&
ln -s $VERSION current
