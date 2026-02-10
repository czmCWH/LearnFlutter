import 'package:get/get.dart';

class GlobalController extends GetxController { 

  // 便捷访问 Controller，
  static GlobalController get to => Get.find(); 

  // 定义响应式数据
  RxString text = "我是全局响应式数据".obs;

  void updateText(String value) {
    text.value = value;
    update();
  }
}