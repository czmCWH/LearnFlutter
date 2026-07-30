import 'package:flutter/material.dart';
import './widgets/index.dart';
import './store/user_inherited_model.dart';
import './store/user.dart';

/// 演示首页。
///
/// 页面本身不持有状态，仅负责组合 UI。所有状态读取通过 [UserInheritedModel.of]
/// 完成，状态写入通过 [UserInheritedModel.update] 完成。
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint("---------- Home Page build");

    return Scaffold(
      appBar: AppBar(title: const Text("InheritedModel Demo")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const NameWidget(),
            const AgeWidget(),
            const VipWidget(),
            const Divider(),
            // 使用 Builder 获取位于 UserInheritedModel 下方的 context，
            // 避免按钮所在 context 与 InheritedModel 的依赖关系产生歧义。
            Builder(
              builder: (innerContext) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // 修改姓名：通过 UserInheritedModel.update 发起更新，
                        // update 不会建立依赖，因此 HomePage 本身不会重建，
                        // 只有订阅了 UserAspect.name 的 NameWidget 会重建。
                        UserInheritedModel.update(
                          innerContext,
                          (User user) => user.copyWith(
                            name: "Jack ${user.age}",
                          ),
                        );
                      },
                      child: const Text("修改姓名"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 修改年龄：仅 AgeWidget 会重建。
                        UserInheritedModel.update(
                          innerContext,
                          (User user) => user.copyWith(
                            age: user.age + 1,
                          ),
                        );
                      },
                      child: const Text("修改年龄"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 切换 VIP 状态：仅 VipWidget 会重建。
                        UserInheritedModel.update(
                          innerContext,
                          (User user) => user.copyWith(
                            isVip: !user.isVip,
                          ),
                        );
                      },
                      child: const Text("修改VIP"),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
