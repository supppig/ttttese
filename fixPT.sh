#!/bin/bash

dir="./artifact/firmware"

fiximg() {
    gzip -dc $1 > tmp.img
    dd if=sdcardPT of=tmp.img bs=512KB conv=notrunc
    gzip -9 tmp.img
    mv -f tmp.img $1
}

for i in $(ls $dir)
do
    fiximg ${dir}/$i
done
