# 黑苹果
 
 
## 笔记本型号
  神州战神Z6-SL7D1
  
## Clover
支持到10.15.7

## OpenCore

- 显示器正常
- 有线，无线网卡正常
- 声音正常
- USB正常
- 蓝牙正常，但速度很慢
- 摄像头正常
- 键盘，触摸板正常
- 睡眠正常
- 亮度快捷键调节正常
- 电源管理
- 隔空投送可以显示，但无法使用


## ACPI文件说明
- 具体直接看文件中的说明。

## 出现的问题⚠️
问题一：时间总会保持再上次关机，睡眠的时刻。\
解决办法:做一个Ubuntu引导盘(Linux),通过BIOS从U盘启动进入，运行Ubuntu系统重启即可\
\
问题二：使用SSDT-PLUG补丁后，睡眠唤醒之后电池状态信息不正确。\
问题分析：可能是睡眠不能不完美造成的或者是其它原因。以前没有对电源修补时是没有这个问题。\
解决办法：目前可以直接不使用SSDT-PLUG补丁就能正常显示电池信息，但是没有节能4项，只有2项,不过不影响使用，睡眠，电源管理功能都是正常的。



<!-- 
  
## OpenCore配置教程
准备工具：
1. [OpencoreConfigurator](https://mackie100projects.altervista.org/download-opencore-configurator/):config GUI配置工具
2. [Hackintool](https://github.com/headkaze/Hackintool)：显卡修复工具
3. [ProperTree]( https://github.com/corpnewt/ProperTree.git):基于Python的跨平台config编辑工具
4. [OC-Gen-X](https://github.com/Pavo-IM/OC-Gen-X):config.plist自动生成工具
5. [OpenCore-Install-Guide](https://dortania.github.io/OpenCore-Install-Guide/):config详细配置教程
6. [OpenCore Sanity Checker](https://opencore.slowgeek.com/):config校验网站

-->

