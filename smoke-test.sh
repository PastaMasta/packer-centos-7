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

# We're using libvirt here boyos
if ! /usr/bin/vagrant plugin list | grep -q vagrant-libvirt ; then
  /usr/bin/vagrant plugin install vagrant-libvirt
fi

# If we're not part of libvirt we can't do anything!
if ! id --groups --name | grep -q libvirt ; then
  id
  echo "I'm not part of the libvirt group!"
  exit 1
fi

# If we're not part of qemu we can't do anything!
if ! id --groups --name | grep -q qemu ; then
  id
  echo "I'm not part of the qemu group!"
  exit 1
fi


# Tidy up any existing boxes
/usr/bin/vagrant destroy
for existing_box in `/usr/bin/vagrant box list | awk '/candidate/{print $1}'` ; do
  /usr/bin/vagrant box remove ${existing_box}
done

sudo virsh -c qemu:///session pool-refresh --pool ${libvirt_pool}
for img in `sudo virsh -c qemu:///session vol-list ${libvirt_pool}| awk '/candidate/{print $1}'` ; do
  sudo virsh -c qemu:///session vol-delete ${img} --pool ${libvirt_pool}
done
sudo virsh -c qemu:///session pool-refresh --pool ${libvirt_pool}

# Add and test
/usr/bin/vagrant box add --name ${boxname} ${box}
/usr/bin/vagrant up
/usr/bin/vagrant ssh -c 'echo It works!' || exit 1
/usr/bin/vagrant destroy
