#!/usr/bin/env bash

set -x

apt-get -qq update
apt-get install -y wget gnupg2

echo 'deb http://archive.ubuntu.com/ubuntu bionic main restricted universe multiverse' | tee /etc/apt/sources.list.d/bionic.list
echo 'deb http://archive.ubuntu.com/ubuntu bionic-updates main restricted universe multiverse' | tee /etc/apt/sources.list.d/bionic-updates.list
echo 'deb http://archive.neon.kde.org/dev/stable/ bionic main' | tee /etc/apt/sources.list.d/neon-stable.list

wget -qO - 'http://archive.neon.kde.org/public.key' | apt-key add -

apt-get -qq update

apt-get install -y build-essential automake autotools-dev libtool wget patchelf xxd desktop-file-utils g++ git cmake libglib2.0-dev zlib1g-dev libcairo2-dev libssl-dev libfuse-dev

cd /mnt

git clone https://github.com/AppImage/AppImageKit.git --depth 1
cd AppImageKit
git submodule update --init

mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBUILD_TESTING=ON -DAPPIMAGEKIT_PACKAGE_DEBS=ON || exit 1
make || exit 1

cpack

