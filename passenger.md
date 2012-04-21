## Passenger

Install:

    sudo gem install passenger
    sudo passenger-install-apache2-module 

Add passegner conf to Apache conf:

    sudo chmod u+w /etc/apache2/httpd.conf

Append:

    export ruby_dir = /opt/ruby/1.9.3-p125
    export passenger_gem = passenger-3.0.11
    cat >> /etc/apache2/httpd.conf

    # Passenger
    LoadModule passenger_module $ruby_dir/lib/ruby/gems/1.9.1/gems/$passenger_gem/ext/apache2/mod_passenger.so" 
    PassengerRoot $ruby_dir/lib/ruby/gems/1.9.1/gems/$passenger_gem
    PassengerRuby $ruby_dir/bin/ruby

Restart:

    /usr/sbin/apachectl restart

Add a vhost if you want:

    <VirtualHost *:80>
      ServerName www.yourhost.com
      DocumentRoot /somewhere/public    # <-- be sure to point to 'public'!
      <Directory /somewhere/public>
         AllowOverride all              # <-- relax Apache security settings
         Options -MultiViews            # <-- MultiViews must be turned off
      </Directory>
    </VirtualHost>
