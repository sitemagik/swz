#!/bin/sh

# This script depends on the GNU script makeself.sh found at: http://megastep.org/makeself/
# Note: The structure of this package depends on the -rpath,./lib to be set at compile/link time.

version="1.6.4"
arch=`uname -i`

if [ "${arch}" = "x86_64" ]; then
    arch="64bit"
    QtLIBPATH="${HOME}/Qt/5.4/gcc_64"
else
    arch="32bit"
    QtLIBPATH="${HOME}/Qt/5.4/gcc"
fi

if [ -f sweet-qt ] && [ -f sweet.conf ] && [ -f README ]; then
    echo "Building sweet_${version}_${arch}.run ...\n"
    if [ -d sweet_${version}_${arch} ]; then
        rm -fr sweet_${version}_${arch}/
    fi
    mkdir sweet_${version}_${arch}
    mkdir sweet_${version}_${arch}/libs
    mkdir sweet_${version}_${arch}/platforms
    mkdir sweet_${version}_${arch}/imageformats
    cp sweet-qt sweet_${version}_${arch}/
    cp sweet.conf sweet_${version}_${arch}/
    cp README sweet_${version}_${arch}/
    ldd sweet-qt | grep libssl | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} sweet_${version}_${arch}/libs/
    ldd sweet-qt | grep libdb_cxx | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} sweet_${version}_${arch}/libs/
    ldd sweet-qt | grep libboost_system | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} sweet_${version}_${arch}/libs/
    ldd sweet-qt | grep libboost_filesystem | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} sweet_${version}_${arch}/libs/
    ldd sweet-qt | grep libboost_program_options | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} sweet_${version}_${arch}/libs/
    ldd sweet-qt | grep libboost_thread | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} sweet_${version}_${arch}/libs/
    ldd sweet-qt | grep libminiupnpc | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} sweet_${version}_${arch}/libs/
    ldd sweet-qt | grep libqrencode | awk '{ printf("%s\0", $3); }' | xargs -0 -I{} cp {} sweet_${version}_${arch}/libs/
    cp ${QtLIBPATH}/lib/libQt*.so.5 sweet_${version}_${arch}/libs/
    cp ${QtLIBPATH}/lib/libicu*.so.53 sweet_${version}_${arch}/libs/
    cp ${QtLIBPATH}/plugins/platforms/lib*.so sweet_${version}_${arch}/platforms/
    cp ${QtLIBPATH}/plugins/imageformats/lib*.so sweet_${version}_${arch}/imageformats/
    strip sweet_${version}_${arch}/sweet-qt
    echo "Enter your sudo password to change the ownership of the archive: "
    sudo chown -R nobody:nogroup sweet_${version}_${arch}

    # now build the archive
    if [ -f sweet_${version}_${arch}.run ]; then
        rm -f sweet_${version}_${arch}.run
    fi
    makeself.sh --notemp sweet_${version}_${arch} sweet_${version}_${arch}.run "\nCopyright (c) 2014-2015 The sweet Developers\nsweet will start when the installation is complete...\n" ./sweet-qt \&
    sudo rm -fr sweet_${version}_${arch}/
    echo "Package created in: $PWD/sweet_${version}_${arch}.run\n"
else
    echo "Error: Missing files!\n"
    echo "Copy this file to a setup folder along with sweet-qt, sweet.conf and README.\n"
fi

