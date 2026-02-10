import 'package:get/get.dart';

/*
  基于类的属性实现响应式
 */
class Person {
  RxString name = "人类".obs;
  RxInt age = 0.obs;
}
