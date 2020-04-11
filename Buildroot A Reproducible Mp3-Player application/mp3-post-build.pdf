#!/bin/sh

set -u
set -e

# Add a console on tty1
if [ -e ${TARGET_DIR}/etc/inittab ]; then
    grep -qE '^tty1::' ${TARGET_DIR}/etc/inittab || \
	sed -i '/GENERIC_SERIAL/a\
tty1::respawn:/sbin/getty -L  tty1 0 vt100 # HDMI console' ${TARGET_DIR}/etc/inittab
fi

#############################################################################################################################################
## PermitRootLogin for ssh
sed -i '/#PermitRootLogin prohibit-password/c\PermitRootLogin yes' output/target/etc/ssh/sshd_config 

## change prompt to raspi> with red color
sed -i "/export PS1=/c\                 export PS1='\\\e[0;31mraspi> \\\e[m '"  output/target/etc/profile

## aliasing ls -lah
aliasDir="root/mp3_player"
echo 'alias las="ls -lah"' >> output/target/etc/profile
if [ ! -d "${TARGET_DIR}/${aliasDir}" ]; then
	sudo mkdir ${TARGET_DIR}/${aliasDir}
fi

sudo cp $(dirname $0)/playmusic/S50-playmusic-daemon-service ${TARGET_DIR}/etc/init.d/
sudo chmod 777 ${TARGET_DIR}/etc/init.d/S50-playmusic-daemon-service
sudo cp $(dirname $0)/playmusic/playmusic* ${TARGET_DIR}/${aliasDir}
sudo cp $(dirname $0)/playmusic/*.mp3 ${TARGET_DIR}/${aliasDir}
sudo cp $(dirname $0)/playmusic/detectUSB ${TARGET_DIR}/${aliasDir}
sudo cp $(dirname $0)/playmusic/startBluetooth ${TARGET_DIR}/${aliasDir}
sudo chmod -R 777 ${TARGET_DIR}/root
## music installed 

################# Enabling Wifi #######################################
if [ ! -d "${TARGET_DIR}/etc/wpa_supplicant" ]; then
	sudo mkdir ${TARGET_DIR}/etc/wpa_supplicant
fi
sudo chmod 777 ${TARGET_DIR}/etc/wpa_supplicant
if [ ! -f "${TARGET_DIR}/etc/wpa_supplicant/wpa_supplicant.conf" ]; then
	sudo touch ${TARGET_DIR}/etc/wpa_supplicant/wpa_supplicant.conf
fi
sudo chmod 777 ${TARGET_DIR}/etc/wpa_supplicant/wpa_supplicant.conf
sudo cp package/busybox/S10mdev ${TARGET_DIR}/etc/init.d/S10mdev
sudo chmod 777 ${TARGET_DIR}/etc/init.d/S10mdev
sudo cp package/busybox/mdev.conf ${TARGET_DIR}/etc/mdev.conf
sudo chmod 777 ${TARGET_DIR}/etc/mdev.conf









