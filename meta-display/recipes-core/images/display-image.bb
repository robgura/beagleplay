
SUMMARY = "Kiosk Image"
DESCRIPTION = "Basic image to get things started"

inherit core-image

IMAGE_INSTALL:append = " vim"
IMAGE_INSTALL:append = " git"
IMAGE_INSTALL:append = " bash"
IMAGE_INSTALL:append = " gawk"
IMAGE_INSTALL:append = " sed"
IMAGE_INSTALL:append = " grep"
IMAGE_INSTALL:append = " curl"
IMAGE_INSTALL:append = " sudo"
IMAGE_INSTALL:append = " rsync"
IMAGE_INSTALL:append = " ntpdate"
IMAGE_INSTALL:append = " openssh-sshd"

IMAGE_FEATURES:append = " splash"
IMAGE_FEATURES:append = " package-management"
IMAGE_FEATURES:append = " x11-base"
IMAGE_FEATURES:append = " x11"
IMAGE_FEATURES:append = " hwcodecs"
IMAGE_FEATURES:append = " ssh-server-openssh"
