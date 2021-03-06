# Unix » <br> Installation help notes for our internal systems

Read me first:

  * <a href="security.txt">security.txt</a>
  
To create a new system:

  * <a href="virtualbox.md">virtualbox.md</a> for VirtualBox
  * <a href="aws.md">aws.md</a> for Amazon Web Services
  * <a href="aws-ec2-ssh-fingerprint-verification.md">aws-ec2-ssh-fingerprint-verification.md</a> to verify AWS fingerprints
  * <a href="centos-rosehosting-notes.txt">centos-rosehosting-notes.txt</a> for older CentOS using Rose Hosting
  * <a href="aptitude-update-upgrade-autoclean.txt">aptitude-update-upgrade-autoclean.txt</a> to upgrade Debian/Ubuntu to current
  * <a href="yum-install-packages-we-like.md">yum-install-packages-we-like.md</a> for RedHat
  
Setups:

  * <a href="fresh.md">fresh.md</a> to set up a fresh system with our SixArm git clones etc. (caution: needs updating)
  * <a href="debian-repositories.txt">debian-repositories.txt</a> (TODO: refactor these to their own files)
  * <a href="disable-dnsmasq-to-help-etc-hosts.md">disable-dnsmasq-to-help-etc-hosts.md</a> 

  
Configurations:

  * <a href="dpkg-reconfigure-debconf-readline.sh">dpkg-reconfigure-debconf-readline.sh</a> if we get errors about readline
  * <a href="color_notes.txt">color_notes.txt</a> on XTerm, TERM, etc.

Languages:

  * <a href="ruby-build.sh">ruby-build.sh</a> 
        ruby-build --definitions
        ruby-build 2.0.0-p247 /opt/rubies/2.0.0-p247
        
Applications:

  * <a href="emacs.md">emacs.md</a> (better to use emacs starter kit if available)
  * <a href="gcc-install-from-scratch.md">gcc-install-from-scratch.md</a> for GCC in extreme atypcal cases
  * <a href="gem-sources.txt">gem-sources.txt</a> for Ruby gem sources
  * <a href="git_branch_parser.sh">git_branch_parser.sh</a> (better to use oh-my-zsh if available)
  * <a href="sublime.md">sublime.md</a> for Sublime Text editor
  * <a href="https://www.gnu.org/software/datamash/">DataMash</a> for command-line statistics
  
Clones:

  * <a href="git_projects.txt">git_projects.txt</a> we use

Clones loop:

    cd /opt
    cat sixarm_unix_installation_help | xargs -I{} git clone --depth 1 {}
    
  
