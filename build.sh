#!/usr/bin/env bash
mkdir build
cd build
git clone https://dev.gnupg.org/source/gpg4win.git
cd ..
docker build -t gpg4win/4885156ed8b7 .
