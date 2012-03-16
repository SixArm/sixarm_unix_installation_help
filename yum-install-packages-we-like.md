# Red Hat Enterprise Linux: yum install packages we like


Libraries:

    yum install -y
      lcms lcms-devel   
      libICE libICE-devel
      libjpeg libjpeg-devel
      libpng libpng-devel
      libSM libSM-devel
      libtiff libtiff-devel 
      libxml2 libxml2-devel
      libxslt libxslt-devel

    yum install -y
      curl curl-devel
      freetype freetype-devel
      ghostscript ghostscript-devel
      openssl openssl-devel
      zlib zlib-devel

Sysop:

    yum install -y
      bzip2 bzip2-devel
      emacs git screen tar wget tidy

Development:

    yum install gcc gdb

Languages:

    yum install 
      java
      gcc-java
      libgcj
      libgcj-devel
      log4j
      postgresql-jdbc
      regexp
      tomcat5
      xalan-j2
      xalan-j2-xsltc
      xerces-j2
      xmlrpc
      xml-commons

    yum install
      python 
      python-devel 
      python-elementtree 
      python-genshi 
      python-iniparse 
      python-ldap 
      python-libs 
      python-numeric 
      python-pycurl 
      python-setuptools 
      python-simplejson
      python-sqlite 
      python-tools 
      python-urlgrabber 

    yum install
      ruby
      ruby-devel 
      ruby-docs 
      ruby-irb 
      ruby-libs 
      ruby-mode 
      ruby-rdoc 
      ruby-ri 
      ruby-tcltk 

    yum install 
      perl
      perl-Archive-Zip
      perl-Bit-Vector 
      perl-Compress-Raw-Zlib
      perl-Compress-Zlib
      perl-Crypt-SSLeay 
      perl-DBD-MySQL 
      perl-DBD-Pg 
      perl-DBI 
      perl-Date-Calc 
      perl-DateManip 
      perl-Digest-HMAC 
      perl-Digest-SHA1 
      perl-Filesys-Ext2
      perl-HTML-Parser
      perl-HTML-Tagset
      perl-HTML-Template
      perl-IO-Compress-Base
      perl-IO-Compress-Zlib
      perl-IO-Socket-INET6
      perl-IO-Socket-SSL
      perl-IO-String
      perl-IO-Zlib
      perl-IPC-ShareLite
      perl-Net-DNS
      perl-Net-IP
      perl-Net-SSLeay
      perl-Proc-Daemon
      perl-Socket6
      perl-String-CRC32
      perl-TermReadKey
      perl-URI
      perl-XML-Dumper
      perl-XML-Grove
      perl-XML-LibXML
      perl-XML-LibXML-Common
      perl-XML-NamespaceSupport
      perl-XML-Parser
      perl-XML-SAX
      perl-XML-Simple
      perl-XML-Twig
      perl-libwww-perl
      perl-libxml-perl

    yum install
      xorg-x11-filesystem
      xorg-x11-fonts-Type1
      xorg-x11-fonts-base
      xorg-x11-fonts-misc
      xorg-x11-fonts-truetype
      xorg-x11-proto-devel
      xorg-x11-resutils
      xorg-x11-server-Xorg
      xorg-x11-server-Xvfb
      xorg-x11-server-Xvnc-source
      xorg-x11-server-sdk
      xorg-x11-server-utils
      xorg-x11-util-macros
      xorg-x11-utils
      xorg-x11-xbitmaps
      xorg-x11-xfwp
      xorg-x11-xinit
      xorg-x11-xkb-utils
      xorg-x11-xsm
      xorg-x11-xtrans-devel

Mail:

    yum install postfix mutt

Databases:

    yum install -y 
      mysql mysql-devel
      postgresql postgresql-devel
      sqlite sqlite-devel

Apache:

    yum install -y
      httpd httpd-devel
      apr apr-devel
      apr-util apr-util-devel

Graphics:

    yum install -y
      libjpeg libjpeg-devel
      libpng libpng-devel
      libtiff libtiff-devel

    yum install -y
      freetype freetype-devel
      ghostscript ghostscript-devel

    yum install -y
      ImageMagick
      ImageMagick-devel
      ImageMagick-c++
      ImageMagick-c++-devel
      ImageMagick-perl
