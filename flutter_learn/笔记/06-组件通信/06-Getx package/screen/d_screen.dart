import 'package:flutter/material.dart';
import 'package:get/get.dart';

/*
  1、Getx 国际化

  2、GetUtils 数据验证
    GetUtils 是 Getx 提供的工具类库，提供的功能有：
      - 值是否为空；
      - 是否是数字；
      - 是否是视频、图片；
      - 日期；
      - MD5；
      - SHA1；

 */

class ScreenD extends StatefulWidget {
  const ScreenD({super.key});

  @override
  State<ScreenD> createState() => _ScreenDState();
}

class _ScreenDState extends State<ScreenD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("D页面"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            Text("hello".tr, style: TextStyle(fontSize: 16, color: Colors.blue),),
            Text("title".tr, style: TextStyle(fontSize: 16, color: Colors.red),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.updateLocale(Locale("en", "US"));
                  }, 
                  child: Text("切换英文"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.updateLocale(Locale("zh", "CN"));
                  }, 
                  child: Text("切换中文"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // GetUtils 数据验证
  void _isEmail(String text) {
    if (GetUtils.isEmail(text)) {
      Get.snackbar("提示", "是邮箱", backgroundColor: Colors.greenAccent);
    } else {
      Get.snackbar("提示", "不是邮箱", backgroundColor: Colors.redAccent);
    }

    // GetUtils.isPhoneNumber(s)
    // GetUtils.isImage(filePath)
    // GetUtils.isVideo(filePath)
    // GetUtils.isDateTime(s)
    // 等等...

  }


}