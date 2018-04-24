#!/usr/bin/env bash


set -x

apt-get -qq update
apt-get install -y wget apt gnupg2

wget -qO - 'http://archive.neon.kde.org/public.key' | apt-key add -
echo 'deb http://archive.neon.kde.org/dev/stable/ bionic main' | tee /etc/apt/sources.list.d/neon-stable.list

wget -qO - 'http://repo.nxos.org/public.key' | apt-key add -
echo 'deb http://repo.nxos.org/testing/ nxos main' | tee /etc/apt/sources.list.d/nxos-testing.list

apt-get -qq update

apt-get install -y build-essential git cmake extra-cmake-modules pkg-config libappimage-dev qtbase5-dev libglib2.0-dev \
    libcairo2-dev libssl-dev

cd /mnt

git clone https://github.com/nomad-desktop/appimage-desktop-integration.git --depth 1
cd appimage-desktop-integration

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release && make && cpack