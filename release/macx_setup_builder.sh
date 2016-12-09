#!/bin/sh

# Note: The structure of this package depends on the -rpath,./lib to be set at compile/link time.

version="1.6.5.5"
arch=`uname -m`

if [ "${arch}" = "x86_64" ]; then
    arch="64bit"
else
    arch="32bit"
fi

if [ -f sweet-Qt.app/Contents/MacOS/sweet-Qt ] && [ -f sweet.conf ] && [ -f README ]; then
    echo "Building sweet_${version}_${arch}.pkg ...\n"
    cp sweet.conf sweet-Qt.app/Contents/MacOS/
    cp README sweet-Qt.app/Contents/MacOS/

    # Remove the old archive
    if [ -f sweet_${version}_${arch}.pkg ]; then
        rm -f sweet_${version}_${arch}.pkg
    fi

    # Deploy the app, create the plist, then build the package.
    macdeployqt ./sweet-Qt.app -always-overwrite
    pkgbuild --analyze --root ./sweet-Qt.app share/qt/sweet-Qt.plist
    pkgbuild --root ./sweet-Qt.app --component-plist share/qt/sweet-Qt.plist --identifier org.sweet.sweet-Qt --install-location /Applications/sweet-Qt.app sweet_${version}_${arch}.pkg
    echo "Package created in: $PWD/sweet_${version}_${arch}.pkg\n"
else
    echo "Error: Missing files!\n"
    echo "Run this script from the folder containing sweet-Qt.app, sweet.conf and README.\n"
fi

