#!/usr/bin/env bash

# cspell:ignore beagleplay bitbake chrpath cleanall debianutils diffstat iputils latr
# cspell:ignore libegl liblz libsdl noprofile norc rootfs runall scarthgap socat sstate webgtk yoctoproject zstd

GIT_ROOT=$(git rev-parse --show-toplevel)
SRC_DIR=${GIT_ROOT}
YOCTO_SRC_DIR=${SRC_DIR}/yocto/meta
OE=${YOCTO_SRC_DIR}/poky/oe-init-build-env

alert=$(tput setab 2)$(tput setaf 7)$(tput bold)
blue=$(tput setaf 4)
error=$(tput setab 1)$(tput setaf 7)$(tput bold)
green=$(tput setaf 2)
magenta=$(tput setaf 5)
orange=$(tput setaf 3)
red=$(tput setaf 1)
reset=$(tput sgr0)
warning=$(tput setab 3)$(tput setaf 7)$(tput bold)

COMMANDS=" \
    -h \
    --help \
    bitbake \
    clean \
    clean-image \
    clean-world \
    clobber-all \
    copy-result \
    fetch-only \
    install-packages \
    repo-setup \
    dry \
"

# scarthgap
MACHINE_NAME=beagleplay-ti
TARGET=build-beagleplay
DEFAULT_PACKAGE=display-sd-installer

### handle tab completion options
if [ "$1" = "--tab-options" ]
then
    # useful to filter completions based on the most recent argument
    # last_argument="${*: -1}"

    echo "${COMMANDS}" | tr '\n' ' ' | sed s/://g | sed s/long\ //g
    exit 0
fi

if [ ! -f /etc/bash_completion.d/build_yocto.sh ] && [ -d /etc/bash_completion.d ]
then
    echo Installing tab completion script for a more pleasant user experience

    cat <<HeRe | sudo tee /etc/bash_completion.d/build_yocto.sh > /dev/null
_tab()
{
    e=\$(expr \$COMP_CWORD - 1)
    local program=\${COMP_WORDS[0]}
    local cur=\${COMP_WORDS[COMP_CWORD]}
    local opts=\$(\${program} --tab-options \${COMP_WORDS[@]:1:\${e}})
    COMPREPLY=( \$(compgen -W "\${opts}" -- \$cur) )
}

complete -F _tab build_yocto.sh

HeRe
fi

beep_beep() {
    # beep beep
    printf "\a"
    sleep .25
    printf "\a"
}

# install_packages() {
#     sudo apt install -y \
#         build-essential \
#         chrpath \
#         cpio \
#         debianutils \
#         diffstat \
#         gawk \
#         gcc \
#         git \
#         iputils-ping \
#         libegl1-mesa \
#         liblz4-tool \
#         libsdl1.2-dev \
#         mesa-common-dev \
#         python3 \
#         python3-git \
#         python3-jinja2 \
#         python3-pexpect \
#         python3-pip \
#         python3-subunit \
#         socat \
#         texinfo \
#         unzip \
#         wget \
#         xterm \
#         xz-utils \
#         zstd \
#
# }
#
# git_clone() {
#     url=$1
#     branch=$2
#     out_dir=$(basename $url)
#
#     if [ -d ${out_dir} ]
#     then
#         echo ${green}updating ${blue}${out_dir}${reset}
#         (cd ${out_dir} && git checkout ${branch})
#     else
#         echo ${green}cloning ${blue}${url}${reset}
#         git clone -b ${branch} ${url}
#     fi
# }
#
# repo_setup() {
#     if [ ! -d ${YOCTO_SRC_DIR} ]
#     then
#         echo ${error}need ${YOCTO_SRC_DIR}${reset}
#         exit 90
#     fi
#
#     cd ${YOCTO_SRC_DIR} || exit 91
#
#     git submodule update --init
# }

run_bitbake() {
    if (( $(grep MemTotal /proc/meminfo | awk '{print $2}') < 28000000 ))
    then
        echo ${error}not enough total memory to successfully build${reset}
        echo ${red}total memory found ${orange}$(grep MemTotal /proc/meminfo | awk '{print $2}')${reset}
        echo ${green}consider increasing memory used for vm${reset}
        echo ${green}failure usually found building webgtk${reset}
        exit 49
    fi

    if [ ! -f ${OE} ]
    then
        echo ${error}need to setup repos first${reset}
        echo could not find ${OE}
        exit 48
    fi

    source ${OE} ${TARGET}
    export LOCAL_ROOT=${SRC_DIR}
    export YOCTO_ROOT=${YOCTO_SRC_DIR}
    export BB_ENV_PASSTHROUGH_ADDITIONS="$BB_ENV_PASSTHROUGH_ADDITIONS LOCAL_ROOT YOCTO_ROOT"

    # echo END
    # echo "$*"
    # exit 0

    bitbake "$*"
    # script --return --quiet -c "bitbake $*" /dev/null
    ec=$?

    beep_beep

    if [ $ec -ne 0 ]
    then
        echo ${red}error running bitbake command${reset}
        exit $ec
    fi
}

copy_result() {
    wic_name=$1-${MACHINE_NAME}.rootfs.wic.xz
    src=${GIT_ROOT}/${TARGET}/deploy-ti/images/${MACHINE_NAME}/${wic_name}
    dest=/vagrant/${wic_name}

    if [ ! -f $src ]
    then
        echo ${red}file not found ${orange}${src}
        return 43
    fi

    # only try to copy final image in certain situations
    if [ ${try_copy} = y ]
    then
        if [ ${src} -nt ${dest} ]
        then
            echo ${magenta}copy ${blue}${src} ${magenta}to ${blue}${dest}${reset}
            cp ${src} ${dest}
        else
            ls -latr ${src} ${dest}
            echo ${warning}not copying${reset}${orange} src file is not newer than destination${reset}
            echo ${orange}src" " ${blue}${src}${reset}
            echo ${orange}dest ${blue}${dest}${reset}
        fi
    fi
}

try_copy=y

# if [ ! -d ${GIT_ROOT}/yocto ]
# then
#     echo ${red}expected directory ${blue}${GIT_ROOT}/yocto${reset}
#     echo ${orange}your current working directory is unexpected${reset}
#     exit 33
# fi

# cd ${HOME}/yocto || exit

while [[ "$#" -gt 0 ]]
do
    case $1 in
        -h | --help)
            echo current commands
            echo ${COMMANDS}
            exit 0
            ;;
        dry)
            echo source ${OE} ${SRC_DIR}/${TARGET}
            echo export LOCAL_ROOT=${SRC_DIR}
            echo export YOCTO_ROOT=${YOCTO_SRC_DIR}
            echo export BB_ENV_PASSTHROUGH_ADDITIONS=\""$BB_ENV_PASSTHROUGH_ADDITIONS LOCAL_ROOT YOCTO_ROOT\""
            exit 0
            ;;
        copy-result)
            copy_result ${DEFAULT_PACKAGE}
            exit $?
            ;;
        install-packages)
            install_packages
            exit 0
            ;;
        repo-setup)
            repo_setup
            exit 0
            ;;
        fetch-only)
            run_bitbake ${DEFAULT_PACKAGE} --runall=fetch
            exit $?
            ;;
        bitbake)
            shift
            run_bitbake "${@}"
            exit $?
            ;;
        clean)
            shift
            if [ -z "${*}" ]
            then
                echo expected an argument [package name] after clean
                exit 34
            fi
            run_bitbake -c cleanall "${@}"
            exit $?
            ;;
        clean-image)
            run_bitbake -c clean ${DEFAULT_PACKAGE}
            exit $?
            ;;
        clobber-all)
            cd ${TARGET} || exit
            set -x
            rm -rf ${HOME}/yocto/tmp
            rm -rf ${HOME}/yocto/sstate-cache
            beep_beep
            exit 0
            ;;
        clean-world)
            # The --continue will ignore any dependency errors while cleaning. Continue as much as possible after an error.
            run_bitbake -c cleanall world --continue
            exit $?
            ;;
        *)
            echo unknown argument $1
            exit 22
            ;;
    esac
done

run_bitbake ${DEFAULT_PACKAGE}
echo ${alert}successful build${reset}

copy_result ${DEFAULT_PACKAGE}
