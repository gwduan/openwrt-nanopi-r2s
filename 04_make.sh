#!/bin/bash

# build openwrt
pushd openwrt
begin_time=`date`
make -j1 V=s
end_time=`date`
popd

# repack openwrt*.img.gz
pushd openwrt/bin/targets/*/*
gunzip openwrt*.img.gz
gzip openwrt*.img
sha256sum -b $(ls -l | grep ^- | awk '{print $NF}' | grep -v sha256sums) >sha256sums
popd

echo "Build time:"
echo "Begin: $begin_time"
echo "End:   $end_time"

exit 0
