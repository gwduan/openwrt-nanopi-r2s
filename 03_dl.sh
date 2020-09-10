#!/bin/bash

# downloads files
pushd openwrt
if [ -d ../../../dl ]; then
	ln -s ../../../dl
fi
make download -j8
popd

exit 0
