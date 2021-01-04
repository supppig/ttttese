#!/bin/bash

ori_file="$1"
pkg_file="$2"

upline() {
    a="$1"
    t=`echo $a | cut -d= -f1`'='
    len=${#t}

    find=0

    while read line
    do
        k=${line: 0: ${len}}
        if [ "$t" = "$k" ];then
            echo "debug:"$k
            echo $a >> /tmp/tmp_upline
            find=1
        else
            echo $line >> /tmp/tmp_upline
        fi
    done < /tmp/tmp_op

    [ $find = 0 ] && echo $a >> /tmp/tmp_upline
    mv -f /tmp/tmp_upline /tmp/tmp_op
}


cat $ori_file | sed "/^#/d" | sed "/^$/d" > /tmp/tmp_op
[ -f /tmp/tmp_upline ] && rm -f /tmp/tmp_upline
while read x
do
    if [ ${#x} -gt 5 ] && [ ${x: 0: 1} != "#" ];then
        upline "$x"
    fi
done < $pkg_file
mv -f /tmp/tmp_op $ori_file

