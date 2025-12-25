import 'package:flutter_shop/viewmodels/user.dart';
import 'package:get/get.dart';

/*
  使用 GetX 插件进行全局状态管理，使用如下：
    1、安装插件：flutter pub add get
    2、定义一个继承自 GetxController 的对象，用于全局共享；
    3、在 GetxController 中定义共享属性，并设置其支持响应式更新；
    4、操作 GetxController 的数据：put、find 以及 Obx 组件。
      - ⚠️，必须只 put 一次，find 多次使用。
    5、UI中使用 GetxController，通过 Obx 函数实现。

  ⚠️，此方式是把状态存储在内存中

 */

/// 定义 UserController 对象用于全局共享
class UserController extends GetxController {
  
  // 给属性初始值添加 .obs，创建一个响应式变量 
  var user = UserInfo.fromJSON({}).obs; 

  // 更新共享属性，需访问其 .value 更新
  updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
