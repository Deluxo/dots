#! /bin/sh

FN="$1";
ARG="$2";

if [[ $FN == 'bluetooth' ]]; then
	if
	bluetootchctl power on
fi
