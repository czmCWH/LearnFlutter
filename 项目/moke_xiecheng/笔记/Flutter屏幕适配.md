# Flutter屏幕适配

## Flutter中尺寸的单位

Flutter尺寸单位采用的是逻辑像素，类似于 iOS 中的点pt、Android 的dp.

* 逻辑像素：也被称为与设备或分辨率无关的像素
* 物理像素：又称设备像素，指屏幕的基础单元，也是我们能看到的尺寸。比如iPhone6 的屏幕在宽度方向有750个像素点，高度方向有 1334 个像素点。


逻辑像素 = 物理像素px/devicePixelRatio


在Flutter中，devicePixelRatio 由ui.Window 类提供，Window是 Flutter Framework 连接宿主操作系统的接口。因此，Flutter 的 devicePixelRatio 属性正是引擎层从原生平台中获取的。
而这个值在安卓中就对应着 density，在 iOS 中就对应着 [UIScreen mainScreen].scale。相同逻辑像素在不同分辨率手机的看到的物理像素不一样的原因是每个设备可能都会有不同的 dpr.


例子：一个蓝色盒子：
Container(color: Colors.blue, width: 200, height: 200,)，
它在 iphone 8 和 iphone 13 pro Max 上显示的效果，在 iphone 8 上显示得更大，因为 iphone 8的像素密度更低。

适配效果：让蓝色盒子在各机型上一样大。

## 适配方案

原理：
	以设计稿宽度为基准，来获取屏幕实际宽度相对设计稿宽度的缩放比 ratio；
	获取开发中的尺寸大小相对于设计稿宽度的实际大小；
	通过dart的扩展来减少适配成本；















