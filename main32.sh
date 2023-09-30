#! /bin/bash

# Clone Upstream
git clone https://git.libcamera.org/libcamera/libcamera.git/ -b v0.1.0
cp -rvf ./debian ./libcamera/
cd ./libcamera

for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || echo "Applying Patch $i Failed!"; done

LOGNAME=root dh_make --createorig -y -l -p libcamera_0.1.0

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
