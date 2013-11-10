sudo su
mkdir -p /opt/ruby
ruby-build --definitions | grep "^2\.[0-9]\.[0-9]-p[0-9]\+$" | tail -1 | xargs -I{} ruby-build --verbose {} /opt/ruby/{}
cd /opt/ruby
ln -s 1.9.3* current
