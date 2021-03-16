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

sudo cp -R $dir/Tsc/syntime-osx "/usr/local/bin/"
sudo cp -R $dir/Tsc/com.sayadev.syntime-osx.plist "/Library/LaunchDaemons/"


echo "Chmod localtime-toggle..."

sudo chmod +x /usr/local/bin/syntime-osx

echo "Chmod com.sayadev.syntime-osx.plist..."

sudo chown root /Library/LaunchDaemons/com.sayadev.syntime-osx.plist
sudo chmod 644 /Library/LaunchDaemons/com.sayadev.syntime-osx.plist

echo "Load LaunchDaemons..."

sudo launchctl load -w /Library/LaunchDaemons/com.sayadev.syntime-osx.plist

echo "/usr/local/bin/syntime-osx"
echo "/Library/LaunchDaemons/com.sayadev.syntime-osx.plist"

echo "Done!"
