cd ~/webcache || exit 1
mkdir cs
mkdir cs/ruby
mkdir cs/ruby/mocha

wget-mirror cs/ruby/mocha http://gofreerange.com/mocha/docs/

cd cs/ruby
curl -s http://www.ruby-doc.org/downloads/ruby_2_0_core_rdocs.tgz | tar zxf -
curl -s http://www.ruby-doc.org/downloads/learning-ruby.tar.gz | tar zxf -
curl -s http://www.ruby-doc.org/downloads/ruby_2_0_stdlib_rdocs.tgz | tar zxf -
curl -s http://mattsears.com/articles/2011/12/10/minitest-quick-reference -o minitest-quick-reference-by-matt-sears.html

