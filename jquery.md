## jQuery and jQuery UI

    cd /var/www/

    export k=jquery v=1.7.2
    mkdir -p lib/$k/$v
    cd lib/$k; ln -s $v current; cd -

    export k=jquery-ui v=1.8.18
    mkdir -p lib/$k/$v
    cd lib/$k; ln -s $v current; cd -
