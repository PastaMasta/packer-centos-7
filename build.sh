#! /bin/bash

#
# Wrapper script for building a images with packer
#

function usage {
  echo "$* packer_file.json"
  exit 1
}
[[ $# -lt 1 ]] && usage $0

packer_file=`readlink -e $1`
export PACKER_TMP=./packer_tmp

set -x

[[ ! -x /usr/local/bin/packer ]] && echo 'No packer dum dum!' && exit 1

# Generate key for packer to use during build
ssh-keygen -f id_rsa -P ''
openssl rsa -in ~/.ssh/id_rsa -outform pem > id_rsa.pem
chmod 600 ./id_rsa.pem
sed -i -e "/NEW_SSH_KEY/ s%CHANGE_ME_FOR_NEW_SSH_KEY%`cat id_rsa.pub`%" ./httpdir/centos-7-ks.cfg

# Check and builderize
if /usr/local/bin/packer validate ${packer_file} ; then
  /usr/local/bin/packer build ${packer_file}
else
  echo "Failed to validate ${packer_file}"
  exit 1
fi

rm -rf #{PACKER_TMP}
rm id_rsa id_rsa.pem id_rsa.pub
