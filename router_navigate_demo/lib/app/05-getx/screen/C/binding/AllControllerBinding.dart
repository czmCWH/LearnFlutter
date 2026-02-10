import 'package:get/get.dart';
import '../controller/global.dart';

class AllControllerBinding implements Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies

    // 懒加载 GetxController
    Get.lazyPut<GlobalController>(() => GlobalController());
  }
}