#!/bin/bash

git clone git://linuxtv.org/media_build.git
cd media_build
./build
cp ../patchfiles/si2157* linux/drivers/media/tuners/
cp ../patchfiles/af9035.c linux/drivers/media/usb/dvb-usb-v2/af9035.c
sudo make
sudo make install
sudo wget -c 'https://raw.githubusercontent.com/LibreELEC/dvb-firmware/master/firmware/dvb-demod-si2168-b40-01.fw' -o /lib/firmware/dvb-demod-si2168-b40-01.fw
sudo wget -c 'https://raw.githubusercontent.com/LibreELEC/dvb-firmware/master/firmware/dvb-demod-si2168-02.fw'  -o /lib/firmware/dvb-demod-si2168-02.fw
sudo wget -c 'https://raw.githubusercontent.com/LibreELEC/dvb-firmware/master/firmware/dvb-usb-it9303-01.fw'  -o /lib/firmware/dvb-usb-it9303-01.fw