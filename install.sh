#!/usr/bin/env sh

# installs samurai.sh into /bin
# files: samurai.sh

# [›] tips:
# - exit code such as exit 0 or exit 1 in sh. 0 is successful exit, and 1 or more is failed exit

# ----- exit script on error
set -e

# ----- functions

# checking sudo

echo ":: checking sudo ::"

if [[ $(id -u) != 0 ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO="sudo"
  else
    echo ":: sudo not installed - aborting ::"
    exit 1
  fi
fi

# checking os

if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo ":: linux debian detected - ok ::"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo ":: mac os darwin detected - ok ::"
elif [[ "$OSTYPE" == "cygwin" ]]; then
  echo ":: cygwin detected - aborting ::"
  exit 1;
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  echo ":: freebsd detected - aborting ::"
  exit 1;
else
  echo ":: os not supported - aborting ::"
  exit 1;
fi

# remove old samurai files

echo ":: checking and removing legacy samurai/butlerfox files ::"

if [ -f /usr/local/bin/samurai ]; then
  echo ":: found and removing legacy /usr/local/bin/samurai file ::"
  $SUDO rm /usr/local/bin/samurai
fi

if [ -f /usr/local/bin/samurai-mac ]; then
  echo ":: found and removing legacy /usr/local/bin/samurai-mac file ::"
  $SUDO rm /usr/local/bin/samurai-mac.py
fi

if [ -f /usr/local/bin/samurai-linux ]; then
  echo ":: found and removing legacy /usr/local/bin/samurai-linux file ::"
  $SUDO rm /usr/local/bin/samurai-linux.py
fi

# install new project files
echo ":: installing butlerfox to /usr/local/bin ::"
# example : curl -L -o master.zip http://github.com/zoul/Finch/zipball/master/
# if install via github curl
$SUDO curl -L https://raw.githubusercontent.com/mirageglobe/butlerfox/master/src/fox.sh -o /usr/local/bin/fox

echo ":: symlinking/setting butlerfox ::"
$SUDO chmod ug+x /usr/local/bin/fox
#$SUDO chmod g+x -R /opt/samurai || { echo "[-] failed to install samurai-linux.py"; exit 1; }

# summary

echo ":: summary ::"
echo "  installed butlerfox into /usr/local/bin/fox"
# echo "  symlinked /usr/local/bin/samurai.sh to /opt/samurai.sh"
echo "  to uninstall, delete binary /usr/local/bin/fox"

