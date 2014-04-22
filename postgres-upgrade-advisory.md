# Postgres upgrade advisory

Please install the latest packages (postgresql-9.3 and postgresql-client-9.3) and upgrade the existing clusters with pg_upgradecluster (see manpage).

Please be aware that the installation of postgresql-9.3 will automatically create a default cluster 9.3/main. If you want to upgrade the 9.1/main cluster, you need to remove the already existing 9.3 cluster (pg_dropcluster --stop 9.3 main, see manpage for details).

The old server and client packages are no longer supported. After the existing clusters are upgraded, the postgresql-9.1 and postgresql-client-9.1 packages should be removed.

Please see /usr/share/doc/postgresql-common/README.Debian.gz for details.
