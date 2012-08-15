# Amazon Web Services


## Start

Get Started with EC2 with a Linux/UNIX Instance
http://docs.amazonwebservices.com/AWSEC2/latest/GettingStartedGuide/GetStartedLinux.html

AWS Management Console
https://console.aws.amazon.com/console/home

AWS Management Console › Amazon EC2
https://console.aws.amazon.com/ec2/home


## Create

Click "Launch Instance"

Choose "Classic"

Choose an AMI:

  * Choose the current Ubuntu (Ubuntu Server Cloud Guest 11.10, 64) 64-bit. 
  * We choose this one because it's easy, widely known in the Ruby community, and matches our development environment. 
  * Click "Select".

Instance Details:

  * Number of instances: 1.
  * Instance type: Micro, because this fits our testing needs.
  * Availablity zone: us-east-1a. We choose the region to match wherever we expect the most traffic to us. The "1a" is arbitrary.
  * Advanced Instance Options: all defaults.
  * Click "Continue".

Tags:

  * name: goal; value: ruby on rails development and testing

Create a new Security Group:

  * All defaults


## PEM

The first time we set up AWS, we create a PEM key pair to authenticate us to machines.

Create a new key pair:

  * Name: aws (or whatever we want)
  * Click "Create and Download Key Pair"
  * This will download a file called aws.pem
  * After it downloads, set permissions on it: chmod 400 aws.pem


AWS will now create an instance:

  * i-231a80413c ec2-12-34-56-78.compute-1.amazonaws.com


## Connect


We use the pem file and default username "ubuntu":

    ssh -i aws.pem ec2-ubuntu@ec2-12-34-56-78.compute-1.amazonaws.com

For our laptops:

    ssh -i ~/.ssh/aws.pem ubuntu@ec2-12-34-56-78.compute-1.amazonaws.com

For our ~/.ssh/config:

    Host aws
    User ubuntu
    Hostname ec2-12-34-56-78.compute-1.amazonaws.com
    IdentityFile  ~/.ssh/aws.pem


## Packages

First commands:

    sudo su -
    apt-get update
    apt-get dist-upgrade
    apt-get upgrade
    apt-get install curl emacs gcc git java7-jdk npm perl python r-base ruby
    apt-get install apache2 mysql nagios3 postfix postgresql sqlite3 texinfo

Install SixArm server stack:

    echo "deb http://sixarm.com/deb/repository binary/" >> /etc/apt/sources.list
    echo "deb-src http://sixarm.com/deb/repository source/" >> /etc/apt/sources.list
    apt-get update && apt-get install sixarm-debian-server-packages


## Ruby

Install ruby-build:

    cd /opt
    git clone git://github.com/sstephenson/ruby-build.git
    cd ruby-build/
    ./install.sh 

Install ruby:

    ruby-build -v 1.9.3-p125 /opt/ruby/1.9.3-p125

Gems:

    gem update --system
    gem update
    gem install ffi
    gem install nokogiri
    gem install passenger


## Security

In the AWS console, be sure we're using a security group that allows inbound traffic on the ports we want. 

For example, if we want to run a typical webserver then we need to allow inbound traffic on HTTP port 80.

To play it safe, we can also turn on the Ubuntu firewall:

    sudo ufw enable
    sudo ufw allow 22
    sudo ufw allow 80


## Apache

To enable Apache mods like mod_rewrite and the RewriteEngine:

    a2enmod rewrite

## SixArm repos

Repos:

    mkdir -p /opt/sixarm && cd /opt/sixarm
    for x in \
      sixarm_bash_etc_files \
      sixarm_zsh_etc_files \
      sixarm_debian_dpkg_scripts \
      sixarm_git_gitconfig \
      sixarm_git_scripts \
      sixarm_mysql_scripts \
      sixarm_postgresql_scripts \
      sixarm_postfix_scripts \
      sixarm_ruby_gem_scripts \
      sixarm_unix_shell_scripts \
      sixarm_unix_dot_files \
      ; do git clone "git://github.com/SixArm/$x.git"; done

Append <code>/etc/bash.bashrc</code>

    echo "[ -e /etc/environment ] && source /etc/environment" >> /etc/bash.bashrc
    echo "[ -e /etc/bash.aliases ] && source /etc/bash.aliases" >> /etc/bash.bashrc

