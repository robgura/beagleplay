#!/usr/bin/env bash

DOWNLOAD_DIR=${HOME}/yocto

git_clone() {
    (
        cd ${DOWNLOAD_DIR}

        url=$1
        branch=$2
        out_dir=$(basename $url)

        if [ -d ${out_dir} ]
        then
            echo Updating ${out_dir}
            (cd ${out_dir} && git checkout ${branch} && git pull)
        else
            git clone -b ${branch} ${url}
        fi
    )
}

mkdir -p ${DOWNLOAD_DIR}

git_clone https://git.ti.com/cgit/arago-project/meta-ti scarthgap

git_clone git://git.yoctoproject.org/poky scarthgap
git_clone git://git.yoctoproject.org/meta-arm scarthgap
git_clone https://git.openembedded.org/meta-openembedded scarthgap
