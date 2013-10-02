which curl 1>/dev/null || echo "Please install curl" && exit 1
which wget-mirror 1>/dev/null || echo "Please install wget-mirror from sixarm_unix_shell_scripts repo" && exit 2

mkdir -p ~/webcache

mkdir -p ~/webcache/cs/ruby && cd $_ || exit 10
curl -s http://www.ruby-doc.org/downloads/ruby_2_0_core_rdocs.tgz | tar zxf -
curl -s http://www.ruby-doc.org/downloads/learning-ruby.tar.gz | tar zxf -
curl -s http://www.ruby-doc.org/downloads/ruby_2_0_stdlib_rdocs.tgz | tar zxf -
curl -s http://mattsears.com/articles/2011/12/10/minitest-quick-reference -o minitest-quick-reference-by-matt-sears.html


mkdir -p ~/webcache/cs/ruby/mocha && cd $_ || exit 10
wget-mirror ~/webcache/cs/ruby/mocha http://gofreerange.com/mocha/docs/

