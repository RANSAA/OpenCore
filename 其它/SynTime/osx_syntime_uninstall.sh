#!/usr/bin/env bash 


#切换进入当前目录
path=$0
first=${path:0:1}
if [[ $first == "/" ]]; then
	path=${path%/*}
	cd $path
fi

dir=$(pwd)
echo $dir

echo "This script required to run as root"

sudo rm -R /usr/local/bin/syntime-osx
sudo rm -R /Library/LaunchDaemons/com.sayadev.syntime-osx.plist


echo "Done!"
