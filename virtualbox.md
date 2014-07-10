# Virualbox


## Intro

Download various operating system installers:
http://download.virtualbox.org/virtualbox/

Guides:

  * http://www.sysprobs.com/install-fedora-16-virtualbox-guest-additions-get-working-gnome-shell-inside-virtual-machine


### Download operating systems

ISO downloads:

  * Fedora: http://fedoraproject.org/en/get-fedora-options
  * Ubuntu: http://www.ubuntu.com/download/ubuntu/download


### Guest Additions

The Guest Additions are designed to be installed inside a virtual machine after the guest operating system has been installed. They consist of device drivers and system applications that optimize the guest operating system for better performance and usability. 

<a href="http://www.virtualbox.org/manual/ch04.html#idp55630656">Guest Additions</a> manual 

After installing an OS:

  * Virtualbox > Devices > Install Guest Additions...

On Debian:

    sudo apt-get install virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11

  * Using Ubuntu inside VirtualBox on Win7 you need to reboot Ubuntu after the virtualbox-guest-dkms install before resizing will work.


### Gotchas

If window resize fails:

  * Install the Guest Additions, described above.
  * Use host+G or the menu option under View > Auto-resize Guest Display.

If window resize still fails, you can tell VirtualBox to use a resolution you like.

  * Shutdown VirtualBox.
  * In a terminal shell, type your resolution (e.g. 1600,1200)

     VBoxManage setextradata global GUI/MaxGuestResolution 1600,1200

  * This should maximize all screens to full 100% on all guest os's

