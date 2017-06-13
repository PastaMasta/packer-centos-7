#! /bin/bash

function usage {
  echo "$* build_host"
  exit 1
}
[[ $# -lt 1 ]] && usage $0

build_host=$1

cmd="
set -x
cd `pwd`
/usr/bin/vagrant destroy
/usr/bin/vagrant box remove centos-7
sudo virsh -c qemu:///session vol-delete centos-7_vagrant_box_image_0.img storage
sudo virsh -c qemu:///session pool-refresh storage
/usr/bin/vagrant box add centos-7 ~/builds/packer-centos-7/centos-7.box
/usr/bin/vagrant up
"

set -x

if [[ -z ${build_host} ]] ; then
  bash -c "${cmd}"
else
  ssh -t -X ${build_host} bash -c "${cmd}"
fi
