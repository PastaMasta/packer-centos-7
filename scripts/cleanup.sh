#! /bin/bash -x

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

sync

sleep 1

sync

sleep 1

sync

sleep 1
