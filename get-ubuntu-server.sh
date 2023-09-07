#!/usr/bin/env bash
cd "$(pwd "$0")"

if [ ! -f ubuntu-22.04.3-live-server-amd64.iso ]; then
  wget https://releases.ubuntu.com/22.04.3/ubuntu-22.04.3-live-server-amd64.iso
fi

read -p "Verify download? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "a4acfda10b18da50e2ec50ccaf860d7f20b389df8765611142305c0e911d16fd *ubuntu-22.04.3-live-server-amd64.iso"\
     | shasum -a 256 --check
fi