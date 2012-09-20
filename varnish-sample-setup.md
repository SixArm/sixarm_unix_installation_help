# Varnish sample

Varnish is a high speed reverse proxy cache for webservers.


## Fetch

An example fetch configuration for a typical starting website:

    # Thanks to StackOverflow user Ketola;  http://stackoverflow.com/users/991314/ketola
    # See http://stackoverflow.com/questions/10284813/howto-control-varnish-and-a-browser-using-cache-control-max-age-header-in-a-rai

    sub vcl_fetch {

      # Some hosts, directories, and urls will be purged explicitly by our app,
      # so we can cache the pages for a long time, which for us is a full day. 

      if (req.http.Host ~ "(foo)") {  
        set beresp.ttl = 24h;
      }

      if (req.url ~ "^/assets/") {
	set beresp.ttl = 24h;
      }

      if(req.url == "/robots.txt") {
	set beresp.ttl = 24h;
      }

      # Search results may change fairly quickly as we add new content,
      # so we will cache the results for ten minutes.   

      if (req.url ~ "^/search/" ) {
	set beresp.ttl = 600s;
      }

      # If we have to return an HTTP error code such as 404 Not Found,
      # then we cache it for a very short time because we want to be able
      # to recover quickly from any error condition in our application.

      if(beresp.status == 404) {
	set beresp.http.Cache-Control = "max-age=15";
	set beresp.ttl = 15s;
	set beresp.grace = 15s;
      }

    }