#!/bin/bash

rm -rf openwrt
git clone https://github.com/coolsnowwolf/lede.git openwrt

# customize patches
pushd openwrt
git am -3 ../patches/*.patch
popd

# addition packages
pushd openwrt/package
# luci-theme-argon
rm -rf lean/luci-theme-argon
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git lean/luci-theme-argon
# luci-app-filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/luci-app-filebrowser lean/luci-app-filebrowser
svn co https://github.com/project-openwrt/openwrt/trunk/package/ctcgfw/filebrowser lean/filebrowser
# luci-app-oled
git clone --depth 1 https://github.com/NateLol/luci-app-oled.git lean/luci-app-oled
popd

# initialize feeds
p_list=$(ls -l patches | grep ^d | awk '{print $NF}')
pushd openwrt
# clone feeds
./scripts/feeds update -a
# patching
pushd feeds
for p in $p_list ; do
  [ -d $p ] && {
    pushd $p
    git am -3 ../../../patches/$p/*.patch
    popd
  }
done
popd
popd

#install packages
pushd openwrt
./scripts/feeds install -a
popd

exit 0
