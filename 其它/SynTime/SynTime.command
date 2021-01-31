#!/usr/bin/env bash 

#切换进入当前目录
path=$0
first=${path:0:1}
if [[ $first == "/" ]]; then
    path=${path%/*}
    cd $path
fi

#sleep 0.5

echo 'Tsc Time'

$path/Tsc/Mac.sh

#关闭终端-所有窗口
osascript -e "tell application \"System Events\" to keystroke \"q\" using command down"
#osascript -e 'tell application "Terminal" to quit' &exit

