# !/bin/bash
# my first bash script, testing to automate build process. You may need root to run
# this!

echo "downloading dependencies"
sudo apt-get install build-essential libdigest-sha-perl patchutils libproc-processtable-perl git-core bc ncurses-dev

echo "grabbing raspbian kernel headers"
sudo wget https://raw.githubusercontent.com/notro/rpi-source/master/rpi-source -O /usr/bin/rpi-source && sudo chmod +x /usr/bin/rpi-source && /usr/bin/rpi-source -q --tag-update

echo "and now executing it"
rpi-source

echo "cloning V4L files next"
git clone git://linuxtv.org/media_build.git

echo "fetching custom firmware files"
git clone https://github.com/OpenELEC/dvb-firmware.git

echo "and installing them to /lib/firmware"
cd dvb-firmware
sudo ./install
cd ..

echo "Done. On to the hard part. This takes up to an hour, go for a walk or drink some tea."
cd media_build/v4l
rm -v Makefile
wget https://raw.githubusercontent.com/curtisy1/tvheadend-tc2-patches/master/media_build/v4l/Makefile
cd ..
./build

echo "50% done. Patch necessary files next."
cd linux/drivers/media/usb/dvb-usb-v2/
rm -v af9035.c
wget https://raw.githubusercontent.com/curtisy1/tvheadend-tc2-patches/master/media_build/linux/drivers/media/usb/dvb-usb-v2/af9035.c
cd ..
cd ..
cd tuners/
rm -v si2157.c
rm -v si2157_priv.h
wget https://raw.githubusercontent.com/curtisy1/tvheadend-tc2-patches/master/media_build/linux/drivers/media/tuners/si2157.c
wget https://raw.githubusercontent.com/curtisy1/tvheadend-tc2-patches/master/media_build/linux/drivers/media/tuners/si2157_priv.h
cd
cd media_build

echo "Done patching files, next step will take ~1h again."
make allyesconfig
make

echo "finalizing setup"
sudo make install

echo "Setup finished, now plug in your TC2 and run dmesg"