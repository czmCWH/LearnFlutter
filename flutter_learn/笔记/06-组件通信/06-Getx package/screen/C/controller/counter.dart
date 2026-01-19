import 'package:get/get.dart';

/*
  基于 GetxController 管理多个状态
 */
class CounterController extends GetxController {
  // 1、定义响应式数据，可直接通过 Obx 访问
  RxInt count = 0.obs;
  RxList<String> list = <String>[].obs;

  void inc() {
    count.value++;
  }

  void dec() {
    count.value--;
  }

  void addItem(String item) {
    list.add(item);
  }

  void removeLast() {
    list.removeLast();
  }

  // 2、非 Rx 变量，需要调用 GetxController.update 方法，这样 GetBuilder 才会更新渲染。
  int norCount = 0;

  void incNor() {
    norCount++;
    update();
  }

  void decNor() {
    norCount--;
    update();
  }

}