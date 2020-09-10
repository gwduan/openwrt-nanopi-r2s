#!/bin/bash

# customize configs
pushd openwrt
if [ -r ../config.custom ]; then
  cp ../config.custom .config
else
  cat ../config.seed > .config
  make defconfig
fi
make menuconfig
cp .config ../config.custom
popd

exit 0
