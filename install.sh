#!/bin/sh

# Installs samurai.py into /usr/local/bin

if [[ $(id -u) != 0 ]]; then
	if command -v sudo >/dev/null 2>&1; then
		SUDO="sudo"
	else
		echo >&2 "Requires sudo but it's not installed. Aborting."
		exit 1
	fi
fi

if git ls-files >& /dev/null &&  [[ -f samurai.py ]]; then
	$SUDO cp samurai.py /usr/local/bin/samurai.py || { echo "Failed to install samurai.py into /usr/local/bin."; exit 1; }
else
	$SUDO curl -L https://raw.githubusercontent.com/mirageglobe/samurai/master/samurai.py -o /usr/local/bin/samurai.py || { echo "Failed to install ssh-copy-id into /usr/local/bin."; exit 1; }
	$SUDO chmod +x /usr/local/bin/samurai.py || { echo "Failed to install samurai.py into /usr/local/bin."; exit 1; }
fi
echo "Installed samurai into /usr/local/bin."; exit 0;