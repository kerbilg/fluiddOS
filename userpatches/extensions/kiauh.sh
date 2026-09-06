function post_customize_image__010_download_kiauh() {
    chroot_sdcard_apt_get_update
    chroot_sdcard_apt_get_install git

    chroot_sdcard sudo -u fluidd git clone https://github.com/kerbilg/kiauh.git /home/fluidd/kiauh
}

function post_customize_image__011_install_stack() {
    chroot_sdcard_apt_get_update
    chroot_sdcard_apt_get_install expect
    
    chroot_sdcard sudo -H -u fluidd /home/fluidd/kiauh/kiauh.sh install klipper --count 1 --create-example-cfg
    
    chroot_sdcard sudo -H -u fluidd /home/fluidd/kiauh/kiauh.sh install moonraker
    
    chroot_sdcard sudo -H -u fluidd /home/fluidd/kiauh/kiauh.sh install fluidd
    
    chroot_sdcard sudo -H -u fluidd /home/fluidd/kiauh/kiauh.sh install fluidd-config
}