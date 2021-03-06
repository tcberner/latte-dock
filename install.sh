#!/bin/bash
#Author: Michail Vourlakos, Smith Ar
#Summary: Installation script for Latte Dock Panel
#This script was written and tested on openSuSe Leap 42.1
set -e

build_type=$1
build_type=${build_type:="Release"}

if ! [ -a build ] ; then
    mkdir build
fi

cd build

if [ "$1" == "-translations" ] ; then
    if [ -a po ] ; then
        sudo rm -fr po
    fi
    if [ -a locale ] ; then
        sudo rm -fr locale
    fi
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DKDE_L10N_BRANCH=trunk -DKDE_L10N_AUTO_TRANSLATIONS=ON -DCMAKE_BUILD_TYPE=$build_type ..
    make fetch-translations
else
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=$build_type ..
    make
fi

sudo make install

oldDeskFile="/usr/share/applications/latte-dock.desktop"

# TODO: remove this lines before 0.7 release, it is provided only for
# the users that use the master branch and built it themselves. It
# will help them to not have to different desktop files for Latte
if [ -f $oldDeskFile ] ; then
    sudo rm $oldDeskFile
    echo "Removed old desktop file..."
fi

