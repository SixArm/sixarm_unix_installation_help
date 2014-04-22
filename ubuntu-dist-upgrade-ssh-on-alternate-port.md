# AWS dist-ugrade SSH alternate

AWS says:

To make recovery in case of failure easier, an additional sshd will
be started on port '1022'. If anything goes wrong with the running
ssh you can still connect to the additional one.

If you run a firewall, you may need to temporarily open this port. As
this is potentially dangerous it's not done automatically. You can
open the port with e.g.:

    iptables -I INPUT -p tcp --dport 1022 -j ACCEPT
