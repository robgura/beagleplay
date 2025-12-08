DESCRIPTION = "system to install from sd card to emmc"
LICENSE = "CLOSED"

SRC_URI = "\
    file://emmc-installer \
    file://emmc-installer.service \
    file://led-control.sh \
"

inherit systemd

FILES:${PN} += "\
    ${systemd_unitdir}/system/emmc-installer.service \
    /display-image-emmc.wic.bmap \
    /display-image-emmc.wic.xz \
    /here \
    /opt/emmc-installer/emmc-installer \
    /opt/emmc-installer/led-control.sh \
"

RDEPENDS:${PN} += "bash"
RDEPENDS:${PN} += "bmaptool"

SYSTEMD_SERVICE:${PN} = "emmc-installer.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install[depends] += "display-image:do_image_complete"

do_install() {
    touch ${D}/here
    IMAGE_FILE=$(readlink -f ${DEPLOY_DIR_IMAGE}/display-image-${MACHINE}.rootfs.wic.xz)
    install -m 0644 -D $IMAGE_FILE ${D}/display-image-emmc.wic.xz

    BMAP_FILE=$(readlink -f ${DEPLOY_DIR_IMAGE}/display-image-${MACHINE}.rootfs.wic.bmap)
    install -m 0644 -D $BMAP_FILE ${D}/display-image-emmc.wic.bmap

    install -m 0644 -D ${WORKDIR}/emmc-installer.service ${D}${systemd_unitdir}/system/emmc-installer.service
    install -m 0755 -D ${WORKDIR}/emmc-installer ${D}/opt/emmc-installer/emmc-installer
    install -m 0755 -D ${WORKDIR}/led-control.sh ${D}/opt/emmc-installer/led-control.sh
}
