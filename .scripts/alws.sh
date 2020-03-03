#! /bin/bash

ALWS_DIR="$DEV_HOME/tools/docker/alws";
HERE="$(pwd)";

if [[ "$1" =~ "edit" ]]; then
	vim -O $ALWS_DIR/httpd/apache.conf $ALWS_DIR/docker-compose.yml && sudo DEV_HOME=$DEV_HOME docker restart alws_httpd_1
else
	cd $ALWS_DIR;
	sudo DEV_HOME=$DEV_HOME docker-compose $@;
	cd $HERE;
fi
