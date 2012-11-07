#!/bin/sh

FQDN=$(hostname -f)

# No parameter: copy current directory to clipboard
if [ -z "$1" ]; then
	echo -n "rsync://$USER@${FQDN}${PWD}" | xsel -b
	exit
fi

[ -e "$1" ] || { echo "File '$1' not found!" >&2 ; exit 1 ; }

FULLPATH=$(readlink -n -f "$1")

echo -n "rsync://$USER@${FQDN}${FULLPATH}" | xsel -b
