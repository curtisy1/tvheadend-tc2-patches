#!/bin/bash

git clone git://linuxtv.org/media_build.git
cd media_build
./build
cp ../patchfiles/si2157* linux/drivers/media/tuners/
make
make install