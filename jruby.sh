#!/bin/sh
# This script will require root-level access to install jruby in /opt

## Download
mkdir -p ~/sources
wget http://dist.codehaus.org/jruby/1.3.1/jruby-bin-1.3.1.tar.gz
tar -zxvf jruby-bin-1.3.1.tar.gz

## Install
mkdir -p /opt
mv jruby-1.3.1 /opt
ln -sf /opt/jruby-1.3.1 /opt/jruby

## Install gems for rake, rails, rspec, etc. Add to this list as you like.
/opt/jruby/bin/jruby -S gem install rake                   --test --no-user-install --source 'http://gems.rubyforge.org'
/opt/jruby/bin/jruby -S gem install rails                  --test --no-user-install --source 'http://gems.rubyforge.org'
/opt/jruby/bin/jruby -S gem install rspec                  --test --no-user-install --source 'http://gems.rubyforge.org'
/opt/jruby/bin/jruby -S gem install ramp                   --test --no-user-install --source='http://sixarm.com'
/opt/jruby/bin/jruby -S gem install relevance-rcov         --test --no-user-install --source='http://gems.github.com'
/opt/jruby/bin/jruby -S gem install ActiveRecord-JDBC      --test --no-user-install --source 'http://gems.rubyforge.org'

## Install test gems. These have interdependencies so IMHO it's more reliable to install here than in rake gems:install
/opt/jruby/bin/jruby -S gem install mocha                  --test --no-user-install --source 'http://gems.rubyforge.org'
/opt/jruby/bin/jruby -S gem install thoughtbot-shoulda     --test --no-user-install --source='http://gems.github.com'
/opt/jruby/bin/jruby -S gem install term-ansicolor         --test --no-user-install --source='http://gems.rubyforge.org'
/opt/jruby/bin/jruby -S gem install treetop                --test --no-user-install --source='http://gems.rubyforge.org'
/opt/jruby/bin/jruby -S gem install diff-lcs               --test --no-user-install --source='http://gems.rubyforge.org'
/opt/jruby/bin/jruby -S gem install builder                --test --no-user-install --source='http://gems.rubyforge.org'
/opt/jruby/bin/jruby -S gem install aslakhellesoy-cucumber --test --no-user-install --source='http://gems.github.com'




## Conclude
echo "Suggestion: add jruby to your system's path for all users."
echo "For example:"
echo "   emacs /etc/bash.bashrc"
echo "Append these lines:"
echo "   export JRUBY_HOME=/opt/jruby"
echo "   export PATH=\$PATH:/opt/jruby/bin/"
echo "   export LD_LIBRARY_PATH=/opt/jruby/lib/"

