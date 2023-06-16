# Clone Upstream
git clone https://git.libcamera.org/libcamera/libcamera.git/ -b v0.0.5
cp -rvf ./debian ./libcamera/
cd ./libcamera

for i in ../patches/*.patch; do patch -Np1 -i $i ;done

LOGNAME=root dh_make --createorig -y -l -p libcamera_0.0.5

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
