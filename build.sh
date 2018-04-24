#!/usr/bin/env bash

set -x

apt-get -qq update
apt-get install -y gnupg2 wget

wget -qO - 'http://archive.neon.kde.org/public.key' | apt-key add -
echo 'deb http://archive.neon.kde.org/dev/stable/ bionic main' | tee /etc/apt/sources.list.d/neon-stable.list

wget -qO - 'http://repo.nxos.org/public.key' | apt-key add -
echo 'deb http://repo.nxos.org/testing/ nxos main' | tee /etc/apt/sources.list.d/nxos-stable.list

apt-get -qq update

apt-get install -y build-essential cmake git qtdeclarative5-dev extra-cmake-modules libqt5xmlpatterns5-dev \
    libappimage-dev libcairo2-dev libglib2.0-dev


cd /mnt

git clone https://github.com/nomad-desktop/nx-software-center.git --depth 1
cd nx-software-center

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release && make && cpack
