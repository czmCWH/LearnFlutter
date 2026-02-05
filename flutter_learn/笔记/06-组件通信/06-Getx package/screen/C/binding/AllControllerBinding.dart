import 'package:get/get.dart';
import '../controller/global.dart';

/*
  Get 依赖管理：将 GetxController 绑定到 Page，使得其生命周期与 Page 同步。
 */
class AllControllerBinding implements Bindings {

  @override
  void dependencies() {
    // TODO: implement dependencies

    // 懒加载 GetxController
    Get.lazyPut<GlobalController>(() => GlobalController());
  }
}