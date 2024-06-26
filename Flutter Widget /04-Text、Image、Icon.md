


## Image


### Image.asset

另外也可以根据屏幕像素比来自动加载对应的图片，需要在 `pubspec.yaml` 文件中配置如下：

```
flutter:
  assets:
    - images/cat.png 
    - images/2x/cat.png
    - images/3.5x/cat.png
```

可以把 `images/cat.png` 图片文件可以从磁盘中省略，但是不能把他从 `pubspec.yaml` 文件清单中删除，在设备像素比为 1.0 的设备上，将自动使用 `images/2x/cat.png` 替代。

* 使用 `scale` 参数时，必须提供准确的路径，不能根据屏幕像素比来自动加载对应的图片。

```
Image.asset('assets/images/2x/ke_nan_two.png', scale: 2, width: 200, height: 250)
```

* `filterQuality` 参数表示绘制图像的质量，从高到低为：high->medium->low->none，默认是 `low`。


