#!/usr/bin/env bash

# installs samurai into /usr/local/bin
# files: samurai / samurai-mac.py / samurai-linux.py

if [[ $(id -u) != 0 ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    echo "Sudo not installed. Aborting."
    exit 1
  fi
fi

# remove old samurai files

if [ -f /usr/local/bin/samurai ]; then
  echo "found and removing /usr/local/bin/samurai file"
  sudo rm /usr/local/bin/samurai
fi

if [ -f /usr/local/bin/samurai-mac ]; then
  echo "found and removing /usr/local/bin/samurai-mac file"
  sudo rm /usr/local/bin/samurai-mac.py
fi

if [ -f /usr/local/bin/samurai-linux ]; then
  echo "found and removing /usr/local/bin/samurai-linux file"
  sudo rm /usr/local/bin/samurai-linux.py
fi

# install new samurai files

if git ls-files >& /dev/null && [[ -f samurai ]]; then
  # if installing via git pull/clone
  $SUDO cp samurai /usr/local/bin/samurai || { echo "Failed to install samurai into /usr/local/bin."; exit 1; }
  $SUDO cp samurai-mac.py /usr/local/bin/samurai-mac.py || { echo "Failed to install samurai-mac.py into /usr/local/bin."; exit 1; }
  $SUDO cp samurai-linux.py /usr/local/bin/samurai-linux.py || { echo "Failed to install samurai-linux.py into /usr/local/bin."; exit 1; }
else
  # if install via github curl
  $SUDO curl -L https://raw.githubusercontent.com/mirageglobe/samurai/master/samurai -o /usr/local/bin/samurai
  $SUDO chmod g+x /usr/local/bin/samurai || { echo "Failed to install samurai into /usr/local/bin."; exit 1; }
  $SUDO curl -L https://raw.githubusercontent.com/mirageglobe/samurai/master/samurai-mac.py -o /usr/local/bin/samurai-mac.py
  $SUDO chmod g+x /usr/local/bin/samurai-mac.py || { echo "Failed to install samurai-mac.py into /usr/local/bin."; exit 1; }
  $SUDO curl -L https://raw.githubusercontent.com/mirageglobe/samurai/master/samurai-linux.py -o /usr/local/bin/samurai-linux.py
  $SUDO chmod g+x /usr/local/bin/samurai-linux.py || { echo "Failed to install samurai-linux.py into /usr/local/bin."; exit 1; }
fi

echo "Installed Samurai into /usr/local/bin. To uninstall, delete samurai/samurai-mac.py/samurai-linux.py from folder."; exit 0;
