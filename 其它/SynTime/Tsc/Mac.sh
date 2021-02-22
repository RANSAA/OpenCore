#!/usr/bin/expect


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



#设置密码的值
set password "123" 

#设置超时方式是永久等待
set timeout -1

#expect方式: 进入脚本所在的路径
cd [file dirname $argv0]

#执行脚本 如果没有上一步,这里脚本需要加绝对路径才能正常执行
spawn sudo sntp -sS 182.92.12.11


#expect对通过spawn执行的shell脚本的返回进行判断，是否包含Password字符串
expect "Password"

#如果expect监测到了包含的字符串，将输入send中的内容，\n相当于回车
send "$password\n"


#退出expect返回终端，可以继续输入，否则将一直在expect不能退出到终端
interact


