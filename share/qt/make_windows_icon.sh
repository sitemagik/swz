#!/bin/bash
# create multiresolution windows icon
ICON_DST=../../src/qt/res/icons/sweet.ico

convert ../../src/qt/res/icons/sweet-16.png ../../src/qt/res/icons/sweet-32.png ../../src/qt/res/icons/sweet-48.png ${ICON_DST}
