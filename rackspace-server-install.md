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


## MySQSL

    yum install mysql mysql-devel

    export k=mysql v=5.5.21
    wget http://dev.mysql.com/get/Downloads/MySQL-5.5/$k-$v.tar.gz/from/http://mysql.he.net/
    tar zxvf $k-$v.tar.gz
    cd $k-$v

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


## Ruby Prereqs

Install YAML:

    export k=yaml v=0.1.4
    wget http://pyyaml.org/download/libyaml/$k-$v.tar.gz
    tar zxvf $k-$v.tar.gz
    cd $k-$v 

    ./configure
    make && make install

If we put YAML in a custom directory then edit /etc/environment to merge these:

    LD_LIBRARY_PATH=/opt/yaml/current/lib
    LD_RUN_PATH=/opt/yaml/current/lib
    LDFLAGS=/opt/yaml/current/lib
    LIBS=/opt/yaml/current/lib

Install X11 if you want X or headless browsing for testing:

    yum install 
      xorg-x11-fonts-misc
      xorg-x11-fonts-truetype
      xorg-x11-server-Xorg
      xorg-x11-server-Xvfb

Install libraries:

    yum install 
      gdbm gdbm-devel
      ncurses ncurses-devel
      openssl openssl-devel
      readline readline-devel
      tk tk-devel
      libjpeg libjpeg-devel
      libpng libpng-devel
      libxml2 libxml2-devel
      libxslt libxslt-devel
      zlib zlib-devel

Install ruby-build:

    cd /opt
    git clone git://github.com/sstephenson/ruby-build.git
    cd ruby-build/
    ./install.sh

Install Ruby:

    export k=ruby v=1.9.3-p125
    wget http://ftp.ruby-lang.org/pub/ruby/1.9/$k-$v.tar.gz
    tar zxvf $k-$v.tar.gz
    cd $k-$v

    # Either onfigure with defaults...
    ./configure 

    # Or configure with custom locations...
    ./configure --prefix=/opt/$k/$v --enable-shared --with-opt-dir=/opt/yaml/current

    make && make check && make install

Edit /etc/environment to merge these:

    PATH=/opt/ruby/current/bin
    RUBYOPT='-r rubygems -r psych'

Load environment:

    source /etc/environment

Verify gem runs and you see the intial set of gems:

    gem list

Gem update:

    gem update --system


## Apache Passenger

    yum install -y
      curl curl-devel 
      httpd httpd-devel
      apr apr-devel
      apr-util apr-util-devel
    gem install passenger
    passenger-install-apache2-module

Add lines to our Apache configuration file:

    LoadModule passenger_module /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.11/ext/apache2/mod_passenger.so
    PassengerRoot /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.11
    PassengerRuby /usr/local/bin/ruby

    <VirtualHost *:80>
      ServerName adspacetopten.com
      ServerAlias www.adspacetopten.com
      ServerAdmin webmaster@adspacetopten.com
      ErrorLog logs/adspacetopten.com/error_log
      CustomLog logs/adspacetopten.com/access_log common
      DocumentRoot /opt/rails/adspace_advantage/current/public
      <Directory /opt/rails/adspace_advantage/current/public>
        AllowOverride all
        Options -MultiViews
      </Directory>
    </VirtualHost>

Make the necessary directories then restart Apache:

    mkdir -p /etc/httpd/logs/adspacetopten.com
    mkdir -p /opt/rails/adspace_advantage/current/public
    /etc/init.d/httpd restart

Verify with a test page:

    echo 'Hello' > /opt/rails/adspace_advantage/current/public/index.html

Browse to the URIs to see the test page:

    http://adspacetopten.com
    http://www.adspacetopten.com


## SQLite

Install SQLite:

    export k=sqlite v=3.7.10
    wget http://www.sqlite.org/sqlite-autoconf-3071000.tar.gz
    tar zxvf sqlite-autoconf-3071000.tar.gz
    cd sqlite-autoconf-3071000
    edit sqlite3.c and insert this line anywhere near the top, after the initial configuration:
        #define SQLITE_ENABLE_COLUMN_METADATA
    ./configure --enable-shared --prefix=/opt/$k/$v
    make && make install
    cd /opt/$k
    ln -s $v current

Edit /etc/environment to merge these:

    LD_LIBRARY_PATH=/opt/sqlite/current/lib
    LD_RUN_PATH=/opt/sqlite/current/lib
    LDFLAGS=/opt/sqlite/current/lib
    LIBS=/opt/sqlite/current/lib
    
Load environment:

    source /etc/environment

Install SQLite gem:

    gem install sqlite3 -- --with-sqlite-dir=/opt/sqlite/current


## Rails

Install Rails and Verify:

    gem install rails
    rails new foobar


## Image Graphics

GraphicsMagick:

    export k=graphicsmagick K=GraphicsMagick v=1.3.14
    wget http://downloads.sourceforge.net/project/$k/$k/$v/$K-$v.tar.gz
    tar zxvf $K-$v.tar.gz
    cd $K-$v
    ./configure --enable-shared
    make && make install

GraphicsMagic gme:

    gem install mini_magick

ImageMagick:

    export k=imagemagick K=ImageMagick v=6.7.5-7
    wget http://www.imagemagick.org/download/$K-$v.tar.gz
    tar zxvf $K-$v.tar.gz
    cd $K-$v
    ./configure --enable-shared
    make && make install

ImageMagick will typically put MagickCore here:

    /usr/local/lib/pkgconfig/MagickCore.pc

Or we can find it:

    find / -name MagickCore.pc

The directory is;

    /usr/local/lib/pkgconfig

The directory is needed in the environment when you install the gem:

    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig gem install rmagick


## Adspace Data

MySQL:

    CREATE USER 'adspace'@'localhost' IDENTIFIED BY 'secret';

    CREATE DATABASE adspace_development;
    CREATE DATABASE adspace_test;
    CREATE DATABASE adspace_production;

    GRANT ALL PRIVILEGES ON adspace_development.* TO 'adspace'@'localhost';
    GRANT ALL PRIVILEGES ON adspace_test.* TO 'adspace'@'localhost';
    GRANT ALL PRIVILEGES ON adspace_production.* TO 'adspace'@'localhost';

Import existing data:

    mysql adspace_production < adspace_production.sql
