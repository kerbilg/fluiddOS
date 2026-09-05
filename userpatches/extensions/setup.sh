function post_customize_image__001_change_root_password() {
    # user: root pass: fluidd (yescrypt)
    display_alert "Changing root password..." "" "info"

    local user_hash='$y$j9T$GPv4roQcFJYwGfQt$jjAXS7ooHlIhGMwwZ3O.imigm8LLjtA/x58J.TFL7hB'
    echo "root:${user_hash}" | chroot_sdcard chpasswd -e
}

function post_customize_image__002_setup_user() {
    # user: fluidd pass: fluidd (yescrypt)
    chroot_sdcard useradd -m -s /bin/bash fluidd
    chroot_sdcard usermod -aG sudo,users fluidd

    local user_hash='$y$j9T$GPv4roQcFJYwGfQt$jjAXS7ooHlIhGMwwZ3O.imigm8LLjtA/x58J.TFL7hB'
    echo "fluidd:${user_hash}" | chroot_sdcard chpasswd -e
}

function post_customize_image__003_passwordless_sudo() {
    local sudoers_file="${SDCARD}/etc/sudoers.d/99-fluidd"

    printf '%s\n' 'fluidd ALL=(ALL) NOPASSWD: ALL' > "${sudoers_file}"

    chroot_sdcard chown root:root /etc/sudoers.d/99-fluidd
    chroot_sdcard chmod 0440 /etc/sudoers.d/99-fluidd
    chroot_sdcard visudo -cf /etc/sudoers.d/99-fluidd
}

function post_customize_image__004_add_repo() {
    chroot_sdcard add-apt-repository universe
    chroot_sdcard add-apt-repository multiverse
    chroot_sdcard_apt_get_update
}