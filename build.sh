#! /bin/bash -x

# Work-around for Vagrant post-processor filling /tmp
[[ -d /data/virt/fast_storage ]] && export TMPDIR=/data/virt/fast_storage

[[ -x ~/bin/packer ]] && ~/bin/packer build ./centos-7.json
