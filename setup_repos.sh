#!/usr/bin/env bash

git_clone() {
    url=$1
    branch=$2
    out_dir=$(basename $url)

    if [ -d ${out_dir} ]
    then
        echo Updating ${out_dir}
        (cd ${out_dir} && git checkout ${branch})
    else
        git clone -b ${branch} ${url}
    fi
}

git_clone git://git.yoctoproject.org/poky kirkstone

git_clone git://git.yoctoproject.org/meta-arm kirkstone
git_clone https://git.openembedded.org/meta-openembedded kirkstone
git_clone https://git.ti.com/cgit/arago-project/meta-ti kirkstone
