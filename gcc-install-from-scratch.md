# GCC install from scratch

This post is great:

   http://www.acsu.buffalo.edu/~charngda/cc_build.html

We must get the GCC infrastructure:

   ftp://gcc.gnu.org/pub/gcc/infrastructure/

We will configure the GCC infrastructure using static libaries like this:

   ./configure --disable-shared --enable-static --prefix=/tmp/gcc


## GMP 

GMP is the GNU Multiple Precision Arithmetic Library.

    export k=gmp v=4.3.2
    wget ftp://gcc.gnu.org/pub/gcc/infrastructure/$k-$v.tar.bz2
    bunzip2 $k-$v.tar.bz2
    tar xvf $k-$v.tar
    cd $k-$v

    ./configure --disable-shared --enable-static --prefix=/tmp/gcc
    make && make check && make install


## MPFR

MPFR is the GNU Multiple-precision floating-point rounding library. It depends on GMP.

    export k=mpfr v=2.4.2
    wget ftp://gcc.gnu.org/pub/gcc/infrastructure/$k-$v.tar.bz2
    bunzip2 $k-$v.tar.bz2
    tar xvf $k-$v.tar
    cd $k-$v

    ./configure --disable-shared --enable-static --prefix=/tmp/gcc --with-gmp=/tmp/gcc
    make && make check && make install


## MPC

MPC is the GNU Multiple-precision C library. It depends on GMP and MPFR.

    export k=mpc v=0.8.1
    wget ftp://gcc.gnu.org/pub/gcc/infrastructure/$k-$v.tar.gz
    tar zxvf $k-$v.tar.gz
    cd $k-$v

    ./configure --disable-shared --enable-static --prefix=/tmp/gcc --with-gmp=/tmp/gcc --with-mpfr=/tmp/gcc
    make && make check && make install


## ELF

ELF is a library takes provides architecture-independent size and endian support.

    export k=libelf v=0.8.13
    wget http://www.mr511.de/software/$k-$v.tar.gz
    tar zxvf $k-$v.tar.gz
    cd $k-$v

    ./configure --disable-shared --enable-static --prefix=/tmp/gcc
    make && make check && make install


## GCC

GCC is the GNU Compiler Collection. It depends on GMP, MPFR, MPC, and ELF.

    export k=gcc v=4.6.2
    wget http://www.netgull.com/gcc/releases/$k-$v/$k-$v.tar.gz
    tar zxvf $k-$v.tar.gz

We must build gcc in a scratch directory, so we create it on the
same mount point (within /tmp would trigger cross compile host issues)

    mkdir -p /opt/downloads/gcc-$v-scratch
    cd /opt/downloads/gcc-$v-scratch

We must use the full path to configure, must disable shared, and must not set library path environment variables.

    /opt/downloads/$k-$v/configure
      --disable-shared
      --disable-bootstrap
      --disable-libstdcxx-pch
      --enable-languages=all
      --enable-libgomp
      --enable-lto
      --enable-thread-safe 
      --enable-threads=posix
      --enable-tls
      --with-gmp=/tmp/gcc
      --with-mpfr=/tmp/gcc
      --with-mpc=/tmp/gcc
      --with-libelf=/tmp/gcc
      --with-fpmath=sse
    make && make install

k