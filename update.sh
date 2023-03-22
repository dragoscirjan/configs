#! /bin/bash

git pull origin main

rm -rf 3rdparty

git submodule init
git submodule update