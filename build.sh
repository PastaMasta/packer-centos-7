#! /bin/bash

#
# Build packer on $1
#

function usage {
  echo "$* packer_file.json"
  exit 1
}
[[ $# -lt 1 ]] && usage $0

packer_file=`readlink -e $1`

set -x

[[ ! -x /usr/local/bin/packer ]] && echo 'No packer dum dum!' && exit 1

export PACKER_TMP=./packer_tmp

/usr/local/bin/packer validate ${packer_file} || exit 1
/usr/local/bin/packer build ${packer_file}

rm -rf #{PACKER_TMP}
