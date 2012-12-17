# Amazon AWS EC2 server SSH fingerprint verification 


When I create a new Amazon EC2 server, I connect to it using ssh as usual.

I see the typical warning:

    $ ssh myserver  
    The authenticity of host 'ec2-12-34-567-890.compute-1.amazonaws.com (12.34.567.890)'     can't be established.
    ECDSA key fingerprint is 31:66:15:d2:19:41:2b:09:8a:8f:9f:bd:de:c6:ff:07.
    Are you sure you want to continue connecting (yes/no)? 

### How do I verify the fingerprint before I sign in?

Use the Amazon ec2-get-console-output command.

Use your EC2 private key pem file, certificate pem file, region, and instance:

    ec2-get-console-output \
      --private-key pk-ABCDEF1234567890.pem \
      --cert cert-ABCDEF1234567890.pem \
      --region us-east-1c \
       i-e706689a   

The output shows the ssh host key fingerprints like this:

    ec2: -----BEGIN SSH HOST KEY FINGERPRINTS-----
    ec2: 1024 e0:79:1e:ba:2e:3c:71:87:2c:f5:62:2b:0d:1b:6d:7b  root@ip-10-243-118-182 (DSA)
    ec2: 256 31:66:15:d2:19:41:2b:09:8a:8f:9f:bd:de:c6:ff:07  root@ip-10-243-118-182 (ECDSA)
    ec2: 2048 ce:ec:3b:d3:34:3f:f3:45:76:81:9e:76:7a:d9:f5:e8  root@ip-10-243-118-182 (RSA)
    ec2: -----END SSH HOST KEY FINGERPRINTS-----

