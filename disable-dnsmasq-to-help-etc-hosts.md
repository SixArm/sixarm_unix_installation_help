# Disable dnsmasq to help /etc/hosts

http://askubuntu.com/questions/347152/why-is-the-etc-hosts-file-not-working

http://blog.calebthorne.com/2012/08/broken-etchosts-in-ubuntu-1204.html

A new "feature" in Ubuntu 12.04 desktop edition is to use dnsmasq as a plugin to NetworkManager for local DNS. Dnsmasq is intended to speed up DNS and DHCP services but comes with one unfortunate side effect: dnsmasq caches local DNS and ignores changes to `/etc/hosts`. 

The solution is to disable dnsmasq in the Networkmanager configuration file. 

Open `/etc/NetworkManager/NetworkManager.conf` and comment out the line:

    dns=dnsmasq
