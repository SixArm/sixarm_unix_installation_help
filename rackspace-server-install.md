Rackspace Server Install


## Starters

Yum install packages we like:
yum-install-packages-we-like.md

GCC install from scratch:
gcc-install-from-scratch.md


## Git

Install zlib:

    yum install zlib zlib-devel

Install Git:

    export k=git v=1.7.9.2
    wget http://git-core.googlecode.com/files/git-$v.tar.gz
    tar zxvf git-$v.tar.gz 
    cd git-$v

    ./configure
    make && make install


## General Notes

We typically put custom-installed software in /opt

We typically keep our downloads and build artifacts in a temp directory /opt/downloads 

When we want to install a program "foo" with custom version, we use the configure flag and a symlink like this:

    ./configure --prefix=/opt/foo/1.2.3
    make & make install
    cd /opt/foo && ln -s 1.2.3 current

We have a shortcut:

    export k=foo v=1.2.3
    ...download...
    ./configure --prefix=/opt/$k/$v
    ...make...
    cd /opt/$k && ln -s $v current

When we install libraries with custom versions, we merge them to /etc/environment:

    LD_LIBRARY_PATH=/opt/foo/current/lib
    LD_RUN_PATH=/opt/foo/current/lib
    LDFLAGS=/opt/foo/current/lib
    LIBS=/opt/foo/current/lib
    LD_OPTIONS="-L/opt/foo/currnet/lib -R/opt/foo/current/lib"


## Ruby & Friends

Install YAML:

    export k=yaml v=0.1.4
    wget http://pyyaml.org/download/libyaml/yaml-$v.tar.gz
    tar zxvf yaml-$v.tar.gz
    cd yaml-$v 

    ./configure
    make && make install

If we put YAML in a custom directory then edit /etc/environment to merge these:

    LD_LIBRARY_PATH=/opt/yaml/current/lib
    LD_RUN_PATH=/opt/yaml/current/lib
    LDFLAGS=/opt/yaml/current/lib
    LIBS=/opt/yaml/current/lib

Install ruby-build:

    cd /opt
    git clone git://github.com/sstephenson/ruby-build.git
    cd ruby-build/
    ./install.sh

Install Ruby:

    export k=ruby v=1.9.3-p123
    wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-$v.tar.gz
    tar zxvf ruby-$v.tar.gz
    cd ruby-$v

    ./configure --prefix=/opt/$k/$v --enable-shared --with-opt-dir=/opt/yaml/current
    make && make install
    cd /opt/$k && ln -s $v current

Edit /etc/environment to merge these:

    PATH=/opt/ruby/current/bin
    RUBYOPT='-r rubygems -r psych'

Load environment:

    source /etc/environment

Verify gem runs and you see the intial set of gems:

    gem list

Gem update:

    gem update --system

Install SQLite:

    wget http://www.sqlite.org/sqlite-autoconf-3071000.tar.gz
    tar zxvf sqlite-autoconf-3071000.tar.gz
    cd sqlite-autoconf-3071000
    edit sqlite3.c and insert this line anywhere near the top, after the initial configuration:
        #define SQLITE_ENABLE_COLUMN_METADATA
    ./configure --prefix=/opt/sqlite/3.7.10
    make && make install
    cd /opt/sqlite
    ln -s 3.7.10 current

Edit /etc/environment to merge these:

    LD_LIBRARY_PATH=/opt/sqlite/current/lib
    LD_RUN_PATH=/opt/sqlite/current/lib
    LDFLAGS=/opt/sqlite/current/lib
    LIBS=/opt/sqlite/current/lib
    
Load environment:

    source /etc/environment

Install SQLite gem:

    gem install sqlite3 -- --with-sqlite-dir=/opt/sqlite/current

Install Rails and Verify:

    gem install rails
    rails new foobar
