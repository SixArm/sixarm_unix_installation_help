apt-get install -y mercurial
apt-get install -y golang
cd /opt
hg clone -u release https://code.google.com/p/go
cd go/src
./all.bash
