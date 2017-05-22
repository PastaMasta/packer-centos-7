#! /bin/bash

#
# Build packer on $1
#

function usage {
  echo "$* build_host packer_file.json"
  exit 1
}
[[ $# -lt 2 ]] && usage $0

build_host=$1
packer_file=`readlink -e $2`

cmd="
[[ ! -x /usr/local/bin/packer ]] && echo 'No packer dum dum!' && exit 1
cd `dirname ${packer_file}`
/usr/local/bin/packer validate ${packer_file} || exit 1
/usr/local/bin/packer build ${packer_file}
"

if [[ ${build_host} == "localhost" ]] ; then
  bash -c "${cmd}"
else
  ssh -X ${build_host} bash -c "${cmd}"
fi
