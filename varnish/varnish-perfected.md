##
# A perfected varnish reverse caching proxy VCL script
#
# A useful template default.vcl for others to base theirs upon.
#
# It's painful getting your varnish default.vcl perfectly correct, so here's one to get you started. 
#
# Requires varnish v2.0.5 or later, if you use this with a version before that then be aware that a If-None-Match in the headers will always default in older varnishs to being processed as pass (i.e. bypass the cache) which you may not want to happen. 
#
# Features of the following VCL:
# 
#  * Designed to primarily cache Zope and Plone content.
#
#  * Gives an example of how to "mount" parts of other websites onto your own e.g. here I mount Google Finance and the RePeC economics database. VERY useful for AJAX programming!
#
#  * Uses cunningly designed statically compiled regular expressions to perform VirtualHostMonster style auto-generation of VirtualHostBase paths out of the HTTP headers (includes HTTPS support!). This saves you having to specify them manually for each and every site you host.
#
#  * Enables varnish to serve stale content up to 24h old if Zope has gone down (very useful for performing upgrades), but keeps grace at 20s if the Zope backend is healthy. Note that this bit particularly requires the If-None-Match ETag support in varnish v2.0.5 and later.
#
#  * Patches SVGZ files to be returned as a more compatible SVG + gzip content encoded.
#
#   * Harmonises Content-Encoding to avoid caching too many copies.
#
# From http://www.nedproductions.biz/wiki/a-perfected-varnish-reverse-caching-proxy-vcl-script
#
##

# This VCL config file is adapted from template.vcl in http://pypi.python.org/pypi/plone.recipe.varnish
backend default {
    .host = "localhost";
    .port = "6100";
    .first_byte_timeout = 300s; /* varnish v2.0.3 or later only */
    .probe = {
        .url = "/";
        .timeout = 1s;
        .interval = 5s;
        .window = 1;
        .threshold = 1;
    }
}

backend repec {
        .host = "ideas.repec.org";
        .port = "80";
}

backend google {
    .host = "209.85.229.106"; /*www.google.com";*/
    .port = "80";
}

/* Only permit cluster to purge files from cache */
acl purge {
    "dedi1.nedprod.com";
    "europe1.nedproductions.biz";
    "usa1.nedproductions.biz";
    "localhost";
}

sub vcl_recv {
    /* Before anything else we need to fix gzip compression */
    if (req.http.Accept-Encoding) {
        if (req.url ~ "\.(jpg|png|gif|gz|tgz|bz2|tbz|mp3|ogg)$") {
            # No point in compressing these
            remove req.http.Accept-Encoding;
        } else if (req.http.Accept-Encoding ~ "gzip") {
            set req.http.Accept-Encoding = "gzip";
        } else if (req.http.Accept-Encoding ~ "deflate") {
            set req.http.Accept-Encoding = "deflate";
        } else {
            # unknown algorithm
            remove req.http.Accept-Encoding;
        }
    }

    if (req.request == "PURGE") {
        if (!client.ip ~ purge) {
            error 405 "Not allowed.";
        }
        /* Always purge by URL rather than going via vcl_hash
           as it hashes other factors which break purging */
        purge_url(req.url);
        error 200 "Purged";
    }

    /* Rewrite all requests to /repec/cgi-bin/authorref.cgi to http://ideas.repec.org/cgi-bin/authorref.cgi */
    if (req.url ~ "^/repec/cgi-bin/authorref.cgi\?handle=" || req.url ~ "^/repec/cgi-bin/ref.cgi\?handle=") {
        set req.http.host = "ideas.repec.org";
        set req.url = regsub(req.url, "^/repec", "");
        set req.backend = repec;
        remove req.http.Cookie;
        lookup;
    } else if(req.url ~ "^/googlefinance/finance/converter\?") {
        set req.http.host = "www.google.com";
        set req.url = regsub(req.url, "^/googlefinance", "");
        set req.backend = google;
        remove req.http.Cookie;
        lookup;
    } else {
        set req.backend = default;
        if (req.http.X-Forwarded-Proto == "https" ) {
            set req.http.X-Forwarded-Port = "443";
        } else {
            set req.http.X-Forwarded-Port = "80";
        }
        if (req.http.host ~ "^(www\.|ipv6\.|usa1\.|europe1\.)?([-0-9a-zA-Z]+)\.([a-zA-Z]+)$") {
            set req.http.host = regsub(req.http.host, "^(www\.|ipv6\.|usa1\.|europe1\.)?([-0-9a-zA-Z]+)\.([a-zA-Z]+)$", "\1\2.\3");
            set req.url = "/VirtualHostBase/" req.http.X-Forwarded-Proto
                regsub(req.http.host, "^(www\.|ipv6\.|usa1\.|europe1\.)?([-0-9a-zA-Z]+)\.([a-zA-Z]+)$", "/\1\2.\3:")
                req.http.X-Forwarded-Port
                regsub(req.http.host, "^(www\.|ipv6\.|usa1\.|europe1\.)?([-0-9a-zA-Z]+)\.([a-zA-Z]+)$", "/\2.\3/\2.\3/VirtualHostRoot")
                req.url;
        }
    }


    if (req.request != "GET" &&
        req.request != "HEAD" &&
        req.request != "PUT" &&
        req.request != "POST" &&
        req.request != "TRACE" &&
        req.request != "OPTIONS" &&
        req.request != "DELETE") {
        /* Non-RFC2616 or CONNECT which is weird. */
        pipe;
    }

    if (req.request != "GET" && req.request != "HEAD") {
        /* We only deal with GET and HEAD by default */
        pass;
    }

    if (req.http.Cookie) {
            # We only care about the "__ac.*" cookies, used for authentication and special persistent p_* cookies.
            if (req.http.Cookie ~ "__ac.*" ) {
                    pass;
        }
        # Else strip all cookies
        remove req.http.Cookie;
        }

    if (req.url ~ "createObject") {
        pass;
    }

    /* Keep serving if haproxy goes down (ie; Plone is being serviced). Haproxy
    will return a 503 error page if Plone goes down for us */
    if (req.backend.healthy) {
        set req.grace = 20s; /* Only enable if you don't mind slightly stale content */
    } else {
        set req.grace = 24h;
    }

    lookup;
}

sub vcl_pipe {
    # This is not necessary if you do not do any request rewriting.
    set req.http.connection = "close";
}

sub vcl_hash {
    # Normally it hashes on URL and Host but we rewrite the host
    # into a VirtualHostBase URL. Therefore we can hash on URL alone.
    set req.hash += req.url;

    # One needs to include compression state normalised above
    if (req.http.Accept-Encoding) {
        set req.hash += req.http.Accept-Encoding;
    }

    # Differentiate based on login cookie too
    #set req.hash += req.http.cookie;

    return (hash);
}

sub vcl_hit {
    if (req.request == "PURGE") {
        purge_url(req.url);
        error 200 "Purged";
    }
}

sub vcl_miss {
    if (req.request == "PURGE") {
        error 404 "Not in cache";
    }
}

sub vcl_fetch {
    set obj.grace = 24h; /* Keep at longest used in vcl_recv */

    if (req.url ~ "\.svgz$") {
        # Add a Content-Encoding to match compressed SVG
        set obj.http.Content-Type = "image/svg+xml";
        set obj.http.Content-Encoding = "gzip";
        remove obj.http.Content-Length;
        set obj.ttl = 86400s;
        set obj.http.Cache-Control = "max-age=3600";
        deliver;
    }
    if (req.http.host == "ideas.repec.org" || req.http.host == "www.google.com") {
        set obj.http.Content-Type = "text/html; charset=utf-8"; /* Correct the wrong response */
        set obj.ttl = 86400s;
        set obj.http.Cache-Control = "max-age=3600";
        deliver;
    }
    if (obj.http.Set-Cookie) {
        pass;
    }
    if (req.http.Authorization && !obj.http.Cache-Control ~ "public") {
        pass;
    }
    /* Only use this if you wish to override Plone's CacheFu */
    if (obj.ttl < 3600s) {
        if (obj.http.Cache-Control ~ "(private|no-cache|no-store)") {
            set obj.ttl = 60s; /* Caching everything anonymous for 60s is handy for being slashdotted :) */
        } else {
            set obj.ttl = 3600s;
        }
    }
}


sub vcl_error {
    set obj.http.Content-Type = "text/html; charset=utf-8";
    synthetic {"
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
  <head>
    <title>"} obj.status " " obj.response {"</title>
  </head>
  <body>
    <div style="background-color:yellow;">
      <h1>This website is unavailable</h1>
      <p>If you are seeing this page, either maintenance is being performed
      or something really bad has happened. Try returning in a few minutes.</p>
      <h2>Error "} obj.status " " obj.response {"</h2>
      <p>"} obj.response {"</p>
      <h3>Guru Meditation:</h3>
      <p>XID: "} req.xid {"</p>
      <address>
         <a href="http://www.nedproductions.biz/">ned Productions Ltd.</a>
      </address>
    </div>
    <div style="position:fixed;top:0;left:0;width:100%;height:100%;z-index:-1;">
    <img alt="" src="/static/BBCTestCard.jpg" style="width:100%;height:100%" /></div>
  </body>
</html>
"};
    return (deliver);
}









#Below is a commented-out copy of the default VCL logic.  If you
#redefine any of these subroutines, the built-in logic will be
#appended to your code.
#
#sub vcl_recv {
#    if (req.request != "GET" &&
#      req.request != "HEAD" &&
#      req.request != "PUT" &&
#      req.request != "POST" &&
#      req.request != "TRACE" &&
#      req.request != "OPTIONS" &&
#      req.request != "DELETE") {
#        /* Non-RFC2616 or CONNECT which is weird. */
#        return (pipe);
#    }
#    if (req.request != "GET" && req.request != "HEAD") {
#        /* We only deal with GET and HEAD by default */
#        return (pass);
#    }
#    if (req.http.Authorization || req.http.Cookie) {
#        /* Not cacheable by default */
#        return (pass);
#    }
#    return (lookup);
#}
#
#sub vcl_pipe {
#    return (pipe);
#}
#
#sub vcl_pass {
#    return (pass);
#}
#
#sub vcl_hash {
#    set req.hash += req.url;
#    if (req.http.host) {
#        set req.hash += req.http.host;
#    } else {
#        set req.hash += server.ip;
#    }
#    return (hash);
#}
#
#sub vcl_hit {
#    if (!obj.cacheable) {
#        return (pass);
#    }
#    return (deliver);
#}
#
#sub vcl_miss {
#    return (fetch);
#}
#
#sub vcl_fetch {
#    if (!obj.cacheable) {
#        return (pass);
#    }
#    if (obj.http.Set-Cookie) {
#        return (pass);
#    }
#    set obj.prefetch =  -30s;
#    return (deliver);
#}
#
#sub vcl_deliver {
#    return (deliver);
#}
#
#sub vcl_discard {
#    /* XXX: Do not redefine vcl_discard{}, it is not yet supported */
#    return (discard);
#}
#
#sub vcl_prefetch {
#    /* XXX: Do not redefine vcl_prefetch{}, it is not yet supported */
#    return (fetch);
#}
#
#sub vcl_timeout {
#    /* XXX: Do not redefine vcl_timeout{}, it is not yet supported */
#    return (discard);
#}
#
#sub vcl_error {
#    set obj.http.Content-Type = "text/html; charset=utf-8";
#    synthetic {"
#<?xml version="1.0" encoding="utf-8"?>
#<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
# "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
#<html>
#  <head>
#    <title>"} obj.status " " obj.response {"</title>
#  </head>
#  <body>
#    <h1>Error "} obj.status " " obj.response {"</h1>
#    <p>"} obj.response {"</p>
#    <h3>Guru Meditation:</h3>
#    <p>XID: "} req.xid {"</p>
#    <address>
#       <a href="http://www.varnish-cache.org/">Varnish</a>
#    </address>
#  </body>
#</html>
#"};
#    return (deliver);
#}
