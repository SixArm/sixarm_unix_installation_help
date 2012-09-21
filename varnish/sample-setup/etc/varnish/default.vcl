##
# Varnish setup
#
# This file goes in /etc/varnish/default.vcl
#
# Also needs /etc/default/varnish
#
# From http://abdul-barek-rails.blogspot.com/2012/07/integrate-http-reverse-proxy-cache.html
##
	
backend default {
     .host = "127.0.0.1";
     .port = "8080";
 }

acl purge {
  "localhost";
}

sub vcl_recv {
  if (req.request == "PURGE") {
    if(!client.ip ~ purge) {
      error 405 "Not allowed.";
    }

    purge("req.url ~ ^" req.url "$ && req.http.host == "req.http.host);
  }
}

sub vcl_recv {
    #Clears all caches if requesting method is post or put or delete
    if (req.request == "POST" || req.request == "PUT" || req.request == "DELETE") {
      purge("req.url == " req.url " && req.http.host == " req.http.host);
    }
}

sub vcl_fetch {
       # Make cache for all get request
        if (req.request == "GET") {
                unset beresp.http.Set-Cookie;
                set beresp.cacheable = true;
                set beresp.ttl = 60m;
        }
        if (req.url ~ "^/images/" || req.url ~ "^/javascripts" || req.url ~ "^/stylesheets"){
                set beresp.ttl = 60m;
        }
}
