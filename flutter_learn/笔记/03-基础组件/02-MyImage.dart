/*
https://docs.flutter.cn/ui/widgets/assets

1、AssetBundle
App 有一个 rootBundle，其中包含在构建 App 时随 App 打包的资源。
要向 App 的 rootBundle 添加资源，请将它们添加到 App 的 pubspec.yaml 清单的 flutter 部分的 assets 子部分。
如下 在 pubspec.yaml 中的 flutter 部分添加如下内容：
```
  assets:
    - images/avatar.png
```
注意: pubspec.yaml 文件配置图片资源的路径，该路径是相对于 `pubspec.yaml` 文件的。
     由于 yaml 文件对缩进严格，所以必须严格按照每一层两个空格的方式进行缩进，此处 assets 前面应有两个空格。

2、Image 
Image 为显示图片指定了多种构造方式：
    * Image.new，用于从 ImageProvider 获取图像。
    * Image.asset，用于使用 key 从 AssetBundle 获取图像。需要在 pubspec.yaml 文件中声明图片资源路径。
    * Image.network，用于从 URL 获取图像。
    * Image.file，用于从文件中获取图像。
    * Image.memory，用于从 Uint8List 中获取图像。

Image 支持以下图像格式：JPEG、PNG、GIF、动画 GIF、WebP、动画 WebP、BMP 和 WBMP。
底层平台可能支持其他格式。Flutter将尝试调用平台API来解码无法识别的格式，如果平台API支持解码图像，Flutter将能够渲染图像。

  - fit 属性，控制图片如何适应其显示区域：如：拉伸、裁剪、比例缩放等。
  - alignment 属性，控制图片在显示区域的对齐方式。
  - repeat 属性，当图片小于显示区域时，是否平铺、重复显示。

3、FadeInImage
FadeInImage 适用于任何类型的图像：内存中、本地资产或来自互联网的图片，它的主要作用是在加载图片时首先显示一个占位符效果。

4、Icon
Icon 图形图标 Widget，使用 IconData 中描述的字体绘制的字形。
Icon 没有交互性。对于交互式 Icon，考虑 Material的 IconButton。
Icon 假定呈现的图标是正方形的。非正方形图标可能无法正确渲染。

使用 Material Icons 标识符渲染 Icon 时，从 Google Fonts 站点获取 https://fonts.google.com/icons；
使用 IconData 渲染 Icon 时，https://book.flutterchina.club/chapter3/img_and_icon.html#_3-3-2-icon

Icons：https://api.flutter-io.cn/flutter/material/Icons-class.html

 */

import 'package:flutter/material.dart';


class MyImage extends StatelessWidget {
  
  const MyImage({super.key, this.tipStr});

  final String? tipStr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image 的使用'),
      ),
      body: Center(
          child: Column(children: <Widget>[
            // 1、从 asset 中加载图片
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('images/PurpleFlower.jpg'), width: 100, height: 100, fit: BoxFit.fitHeight, ),
                Image.asset('images/WhiteFlower.jpg', width: 100, height: 100,),
              ],
            ),

            // 2、从网络加载图片
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: NetworkImage("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4"), width: 100.0, height: 100,),
                Image.network("https://docs.flutter.dev/assets/images/dash/dash-fainting.gif", width: 100.0, height: 100,)
              ],
            ),

            // 3、占位图方式加载图片
            FadeInImage.assetNetwork(placeholder: 'images/bluePlace.png', image: 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif', width: 200, height: 200,),

            // 4、使用 Material Icons 标识符 渲染 Icon
            const Icon(
              Icons.beach_access,
              color: Colors.pink,   // 绘制图标的颜色
              size: 60,   // 图标的大小，以逻辑像素为单位
              semanticLabel: "爱心",    // 语意标签，不知道有什么用
            ),
            
            // 5、通过 IconData 渲染 Icon
            const Icon(
              IconData(0xe0d6, fontFamily: 'MaterialIcons', matchTextDirection: true),
              color: Colors.pink,
              size: 50,
              semanticLabel: "小爱心",
              textDirection: TextDirection.rtl,   // 设置图标显示的方向，只在 IconData 的 matchTextDirection 属性为true 时，才生效
            ),

          ],
        ),
      ),
    );
  }
}
