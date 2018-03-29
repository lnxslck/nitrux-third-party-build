#!/usr/bin/env bash


set -x

apt-get -qq update
apt-get install -y wget apt

wget -qO - 'http://archive.neon.kde.org/public.key' | apt-key add -
echo 'deb http://archive.neon.kde.org/dev/stable/ bionic main' | tee /etc/apt/sources.list.d/neon-stable.list

wget -qO - 'http://repo.nxos.org/public.key' | apt-key add -
echo 'deb http://repo.nxos.org/testing/ nxos main' | tee /etc/apt/sources.list.d/nxos-testing.list

apt-get -qq update

apt-get install -y build-essential git cmake extra-cmake-modules pkg-config libappimage-dev libkf5kio-dev libglib2.0-dev libcairo2-dev libssl-dev

cd /mnt

git clone https://github.com/azubieta/KDE-AppImage-Thumbnailer.git --depth 1
cd KDE-AppImage-Thumbnailer

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release && make && cpack