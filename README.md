# x86_assemble

本项目为《x86汇编语言: 从实模式到保护模式》一书的个人示例

目录进度为第5章，

中间按照随书资料中的方法安装Bochs进调试时遇到了两个问题：
1. 书中示例是在windows系统中安装bochs，个人是在自己Macbook上通过brew安装的MacOS平台版本Bochs
2. 尝试通过配置文件配置Bochs加载.vhd类型虚拟硬盘(这个硬盘中有按书中前面章节步骤写入的MBR)，
   总是报错，错误信息有两种，一是找不到BIOS镜像， 二是"can't read .vhd file"

注：上面的安装配置是参考 http://imushan.com/2018/07/11/os/Bochs%E5%AD%A6%E4%B9%A0-%E5%AE%89%E8%A3%85%E9%85%8D%E7%BD%AE%E7%AF%87/ 做的


解决方法：
关于找不到BIOS镜像的问题，主要是设置的bios镜像路径中包含的 $BXSHARE 变量没有设置，需要设置它到Bochs安装路径下的share目录

另外关于读取.vhd文件类型的问题，自已尝试过按照Bochs的bochsrc-sample.txt中列出的选项进行设置，还是有问题。
没办法，只好开了一个Win7虚拟机按照随书资料的说明进行启动，初次启动时需要在窗口模式下按选项设置，最后会得到一个windows版本的配置文件。

后面把Win7虚拟机的文件拷到了Mac下进行一些path选项的修改后再次尝试启动，还是有错误。

直到最后又google了其他信息，发现随书资料的其中一个选项应该是错的，它在设置读取vhd文件路径时，让将vhd文件的mode设置成vpc类型；
但其实是需要将mode设置成flat类型才能成功启动。

附MacOS版本: 10.15.2
Bochs版本: 2.6.9
