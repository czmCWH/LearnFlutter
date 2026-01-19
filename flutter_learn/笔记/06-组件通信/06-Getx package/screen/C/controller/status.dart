import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/*
  GetxController 的生命周期
 */
class StatusController extends GetxController {
  // 1、定义响应式数据
  RxBool result = false.obs;

  void reverse() {
    result.value = !result.value;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    debugPrint("--- GetxController 生命周期函数： onInit，执行请求数据");
    getList();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    debugPrint("--- GetxController 生命周期函数： onReady");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    debugPrint("--- GetxController 生命周期函数： onClose");
  }

  void getList() {
    Future.delayed(Duration(seconds: 2), () {
      debugPrint("--- 请求数据结束");
      result.value = !result.value;
      update();
    });
  }
}