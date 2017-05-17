# !/bin/bash
# my first bash script, testing to automate cruel 
# work. You might need to run this as root.

echo "downloading dependencies"
sudo apt-get install build-essential libdigest-sha-perl patchutils libproc-processtable-perl git-core bc ncurses-dev
echo "downloading raspbian kernel headers"
sudo wget https://raw.githubusercontent.com/notro/rpi-source/master/rpi-source -O /usr/bin/rpi-source && sudo chmod +x /usr/bin/rpi-source && /usr/bin/rpi-source -q --tag-update
echo "and now executing it"
rpi-source
echo "cloning V4L files next"
git clone git://linuxtv.org/media_build.git
echo "fetching custom firmware files"
git clone https://github.com/OpenELEC/dvb-firmware.git
echo "and installing them to /lib/firmware/"
cd dvb-firmware
sudo ./install
cd ..
echo "Done. On to the hard part."
echo "This takes up to an hour,"
echo "Go for a walk or make some tea."
cd media_build/v4l/
rm -v Makefile
wget https://raw.githubusercontent.com/curtisy1/tvheadend-tc2-patches/master/media_build/v4l/Makefile
cd ..
./build
echo "50% done. Patching necessary files next"
cd linux/drivers/media/usb/dvb-usb-v2/
rm -v af9035.c
wget https://raw.githubusercontent.com/curtisy1/tvheadend-tc2-patches/master/media_build/linux/drivers/media/usb/dvb-usb-v2/af9035.c
cd ..
cd .. 
cd tuners/
rm -v si2157.c si2157_priv.h
wget https://raw.githubusercontent.com/curtisy1/tvheadend-tc2-patches/master/media_build/linux/drivers/media/tuners/si2157.c
wget https://raw.githubusercontent.com/curtisy1/tvheadend-tc2-patches/master/media_build/linux/drivers/media/tuners/si2157_priv.h
cd
cd media_build
echo "Done patching files. Next step will take ~1h again"
make allyesconfig
make
echo "Finalizing setup"
sudo make install
echo "Setup finished, now plug in your TC2 stick and run dmesg"
