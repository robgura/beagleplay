
SUMMARY = "installer image"
DESCRIPTION = "image to boot from sd and install real image to emmc"

inherit core-image

IMAGE_FEATURES:append = " allow-empty-password"
IMAGE_FEATURES:append = " allow-root-login"
IMAGE_FEATURES:append = " debug-tweaks"
IMAGE_FEATURES:append = " hwcodecs"
IMAGE_FEATURES:append = " package-management"
IMAGE_FEATURES:append = " ssh-server-openssh"
IMAGE_INSTALL:append = " bash"
IMAGE_INSTALL:append = " bmaptool"
IMAGE_INSTALL:append = " busybox-syslog"
IMAGE_INSTALL:append = " curl"
IMAGE_INSTALL:append = " emmc-installer"
IMAGE_INSTALL:append = " gawk"
IMAGE_INSTALL:append = " git"
IMAGE_INSTALL:append = " grep"
IMAGE_INSTALL:append = " mmc-utils"
IMAGE_INSTALL:append = " parted"
IMAGE_INSTALL:append = " sed"
IMAGE_INSTALL:append = " sudo"
IMAGE_INSTALL:append = " vim"
IMAGE_INSTALL:append = " wget"
IMAGE_INSTALL:append = " xz"

# lksjdlkjfsoi
