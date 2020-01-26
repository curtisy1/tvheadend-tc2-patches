#!/bin/bash

git clone git://linuxtv.org/media_build.git
cd media_build
./build
patch linux/drivers/media/usb/dvb-usb-v2/af9035.c patchfiles/af9035.patch
mv patchfiles/si2157* linux/drivers/media/tuners/
cd linux/drivers/media/usb/dvb-usb-v2/
make allyesconfig
make
make install