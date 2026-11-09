# ONScripter-jh-PSVita (yuri)  

![psv-ons](https://img.shields.io/badge/psv-onscripter-brightgreen)  ![GitHub release (latest by date)](https://img.shields.io/github/v/release/Yurisizuku/psv-OnscripterJH?color=green&logoColor=red&style=flat-square)

This is an ONScripter JH (SDL2) project, ported to psv.  
Maintained by Yurisizuku, optimizing code structure and adding more features. Such as video hardware decode support and nt2, nt3 format support.

- [x] make better structure by cmake
- [x] fix bugs in new vitasdk and rendering problems
- [x] fix bugs for joystick and touching event (this is caused by the scale ratio in y)
- [x] ci in github  action to automaticly build
- [x] support nt2, [nt3](https://github.com/YuriSizuku/GalgameReverse/blob/master/src/onscripter/ons_decryptnt3.c) script format  
- [x] support avc video with hardware decode  
- [x] add English translation on the memu  
- [ ] test and make compatible game list  
...

![vitaons_test2](./screenshot/vitaons_test2.jpg)
![vitaons_test3](./screenshot/vitaons_test3.jpg)
![vitaons_bg](./asset/bg.png)

My other mod for emulators:  
[Mine_v1.5_yuri in andorid](https://github.com/YuriSizuku/Kirikiroid2/releases/download/1.3.9_yuri/Kirikiroid2_yuri_1.3.9.apk)  
[Krkrdorid in andorid](https://github.com/YuriSizuku/Kirikiroid2/releases/download/1.3.9_yuri/Kirikiroid2_yuri_1.3.9.apk)  

## 1. build

Instal [vitasdk](https://vitasdk.org/) first, and then use these script to build and debug.  
I tested it with windows msys `sh` and linux `bash`.  

```sh
#install vitasdk
bash ./script/install_vitasdk.sh [vitasdkdir]

# build a Release package at build/VitaOns.vpk
sh ./script/build_vitavpk.sh vpk [vitasdkdir]

# send script
sh send_vitavpk.sh ./../build/VitaOns.vpk 10.2.12.6 PSVONSEMU
sh build_vitavpk.sh all && sh send_vitaeboot.sh 10.2.12.6
```

## 2. usage

Put ons games into `ux0:onsemu/` and enjoy 🍀  
The game directory should not contain non-asci charactors.  
See original informations in details.  

The Vita movie path uses the system AV player for H.264/AVC in MP4 with 8-bit 4:2:0 video
and mono or stereo AAC. For clips outside the supported decoder formats, start with
720p or smaller at 30 fps. The engine searches for a loose `.mp4` with the same base name
as the movie in the game script.

```sh
ffmpeg -i op.mpg -map 0:v:0 -map '0:a:0?' \
  -vf "scale=w='min(1280,iw)':h='min(720,ih)':force_original_aspect_ratio=decrease:force_divisible_by=2,setsar=1" \
  -fpsmax 30 -c:v libx264 -profile:v main -level:v 3.1 -pix_fmt yuv420p -refs 3 \
  -crf 20 -maxrate 5M -bufsize 10M -c:a aac -ac 2 -ar 48000 -movflags +faststart op.mp4
```

![vitaons_mo2](screenshot/vitaons_mo2.png)

## 3. konwn issues (including already solved)

- [x] CMake builds handle the VitaSDK target naming change for `onsjh.self-self`.
- [x] Some game `*** can't load file [fgimage/CGTM16.png] Out of memory ***`  
  This is because vita homebrew heap size has restriction to 32M.  
  Solved by override [strbrk](https://gitee.com/yizhigai/onscripter-vita/blob/master/onscripter/vita/sbrk.c)  

------
Original informations by [wetor](https://github.com/wetor/ONScripter-jh-PSVita).  
Thank you for providing the code and makefiles to this project.

## 2019.3.3 上传部分源代码  

现在暂无法编译，源代码还在整理中...  
GUI源代码(太乱了)和makefile会在整理完后上传，大学狗没什么时间，可能会鸽一段时间  

## 详细信息  

[beta0.2版本下载](https://blog.wetorx.cn/posts/ONS-PSV/)  
[更新日志请访问](https://blog.wetorx.cn/posts/ONS-PSV/)  
[目前已知BUG列表](https://blog.wetorx.cn/posts/ONS-PSV/)  

## 感谢

感谢 小凱（@kane33936）一直以来的支持！  
感谢 jh10001 对我一些可笑问题的解答！  
感谢 唯一、小凱、光影的初期协助测试！  

## 源代码支持

ONScripter-jh 作者：jh10001（@jh2711H）  
SDL2-Vita 和 SDL2相关库（ttf、mixer、image） 作者：rsn8887  
VitaShell 作者：TheOfficialFloW（TheFlow）  
vita-savemgr 作者：d3m3vilurr  
vhbb 作者：devnoname120  
vitacompanion 作者：devnoname120  
debugnet 作者：psxdev  
sdlpal-vita 作者：usineur  
iniparser 作者：ndevilla  
libvita2d 作者：xerpi  
vita-luajit 作者：hyln9  
VITASDK  
Vita3K  
更多待补充。
