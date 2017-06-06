#! /bin/bash

#
# Build packer on $1
#

function usage {
  echo "$* packer_file.json [build_host]"
  exit 1
}
[[ $# -lt 1 ]] && usage $0

packer_file=`readlink -e $1`
build_host=$2

set -x

[[ ! -L ./cookbooks ]] && ln -sf ~/cookbooks

cmd="
[[ ! -x /usr/local/bin/packer ]] && echo 'No packer dum dum!' && exit 1
export PACKER_TMP=./packer_tmp
cd `dirname ${packer_file}`
/usr/local/bin/packer validate ${packer_file} || exit 1
/usr/local/bin/packer build ${packer_file}
rmdir #{PACKER_TMP}
"

if [[ -z ${build_host} ]] ; then
  bash -c "${cmd}"
else
  ssh -X ${build_host} bash -c "${cmd}"
fi
