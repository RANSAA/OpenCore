#!/bin/sh


# MacOS 10.14以上的版本
# 方法一：使用apple time官网协议
# sudo sntp -sS time.apple.com
 
# # 方法二：外网不好用时，使用阿里云IP
# sudo sntp -sS 182.92.12.11


# MacOS 10.14以下的版本

# 方法一：使用apple time官网协议
# sudo ntpdate -vu time.apple.com
 
# # 方法二：外网不好用时，使用阿里云IP
# sudo ntpdate -vu 182.92.12.11


#运行sh脚本sudo自动输入密码

#第一种方法：使用管道（上一个命令的 stdout 接到下一个命令的 stdin）:
# echo "123" |sudo -S sntp -sS 182.92.12.11

#第二种方法：使用文本块输入重定向:
sudo -S sntp -sS 182.92.12.11 << EOF 
123
EOF


