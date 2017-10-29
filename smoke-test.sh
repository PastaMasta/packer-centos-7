#! /bin/bash

#
# Refreshes a vagrant box and sees if it starts.
#

function usage {
  echo "$* [image.box]"
  exit 1
}
[[ $# -gt 1 ]] && usage $0

box="centos-7-candidate.box"
[[ -n $1 ]] && box=$1

boxname="`basename ${box} | sed -e 's/\.box$//'`"
libvirt_pool="storage"

set -x

# Tidy up any existing boxes
/usr/bin/vagrant destroy
for box in `/usr/bin/vagrant box list | awk '/candidate/{print $1}'` ; do
  /usr/bin/vagrant box remove ${box}
done

for img in `sudo virsh -c qemu:///session vol-list ${libvirt_pool}| awk '/candidate/{print $1}'` ; do
  sudo virsh -c qemu:///session vol-delete ${img} --pool ${libvirt_pool}
done
sudo virsh -c qemu:///session pool-refresh --pool ${libvirt_pool}

# Add and test
/usr/bin/vagrant box add ${boxname} ${box}
/usr/bin/vagrant up
/usr/bin/vagrant ssh -c 'echo It works!' || exit 1
/usr/bin/vagrant destroy