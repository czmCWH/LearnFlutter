/*

Material2 Butttons：https://docs.flutter.cn/ui/widgets/material2#Buttons
<https://api.flutter.dev/flutter/material/TextButton-class.html>


1、TextButton
  - 没有可见边框。
  - 其样式可以通过 Theme 的 ThemeData.textButtonTheme 属性进行全局覆盖。
  - 一般在 toolbar、dialogs 或嵌入其它容器中使用。

用途：用于最低优先级的操作。


2、ElevatedButton
ElevatedButton 是一个凸起的材质矩形按钮。应避免在 dialogs、cards 等已经升高的内容上使用它。
  - 样式都可以用 Theme 的 ThemeData.elevatedButtonTheme 属性覆盖。

用途：用于主要操作、强调。


3、FilledButton
FilledButton 具有最强的视觉冲击力，应该用于完成流程的重要最终操作。

用途：重要最终操作，例如保存、立即加入或确认。


4、OutlinedButton
OutlinedButton 本质上是一个带有轮廓边框的 TextButton。
用途：次要操作。


5、IconButton
IconButton 不能设置背景颜色、title标题。因为 IconButton 通常仅显示在父窗口小部件的背景之上。

6、总结
  - 如上按钮除了 IconButton，都继承自 ButtonStyleButton。
  - ButtonStyleButton 设置样式都是以 (TextButton、 ElevatedButton、 ...).styleFrom 来创建
  - ButtonStyleButton 

 */

import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  
  const MyButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              const Spacer(),
              // 👉 1、TextButton 设置背景色，默认带圆角、文本居中
              TextButton(
                onPressed: () {
                  debugPrint('--- 点击了 TextButton');
                }, 
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(100, 50),  // 固定尺寸
                ),
                child: const Text('TextButton', style: TextStyle(color: Colors.white),)
              ),
              const Spacer(),

              // 👉 2、TextButton 的样式设置
              TextButton(
                onPressed: () {
                  debugPrint('--- 点击了 TextButton');
                }, 
                style: TextButton.styleFrom(
                  foregroundColor: Colors.yellow,    // 文本颜色
                  backgroundColor: Colors.lightBlue,  // 背景颜色
                  shape: RoundedRectangleBorder(      // 按钮形状
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10), // 内部间距
                  minimumSize:  const Size(100, 50),   // 最小尺寸
                ),
                child: const Text('TextButton')
              ),
              const Spacer(),

              // 👉 3、禁用 TextButton 时，把 onPressed 设置为 null 即可。
              const TextButton(
                onPressed: null, 
                child: Text('TextButton')
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(width: double.infinity, height: 50,),

          // 👉 4、TextButton.icon 创建文本 + icon 的文本按钮
          Row(
            children: [
              const Spacer(),
              // 图标在左边（默认）
              TextButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('确认'),
                onPressed: () {},
                iconAlignment: IconAlignment.start,
              ),
              const Spacer(),
              // 图标在右边
              TextButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('确认'),
                onPressed: () {},
                iconAlignment: IconAlignment.end,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(width: double.infinity, height: 50,),

          // 👉 5、ElevatedButton 的使用与 TextButton 基本类似
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              ElevatedButton(
                onPressed: () {

                },
                // ElevatedButton.styleFrom 用于配置 ElevatedButton 的样式
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.amber,
                  padding: const EdgeInsets.all(20),
                  // 按钮形状
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // 阴影深度控制
                  elevation: 2.0,  // 基础阴影，值为 0 时无阴影                         
                ),
                child: const Text('ElevatedButton')
              ),
              ElevatedButton. icon(
                onPressed: () {

                },
                icon: const Icon(Icons.add),
                label: const Text('添加项目'),
                iconAlignment: IconAlignment.start,  // 图标在左边
              ),
            ],
          ),

          // 👉 6、FilledButton 填充按钮
          const SizedBox(height: 50,),
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              FilledButton(onPressed: () {}, child: const Text('Enabled')),
              const FilledButton(onPressed: null, child: Text('Disabled')),
            ],
          ),
          const SizedBox(height: 50,),
          // FilledButton.tonal 构造器
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              FilledButton.tonal(onPressed: () {}, child: const Text('Enabled')),
              const FilledButton.tonal(onPressed: null, child: Text('Disabled')),
            ],
          ),
          const SizedBox(height: 50,),
          // FilledButton.icon 构造器
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              FilledButton.icon(
                onPressed: () {
                  debugPrint('添加操作');
                },
                icon: const Icon(Icons.add),
                label: const Text('添加'),
                iconAlignment: IconAlignment.start,
              ),
              FilledButton.icon(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors. white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(Icons.delete),
                label: const Text('删除'),
              ),
            ],
          ),
          
          const SizedBox(height: 50,),
          // 👉 6、OutlinedButton 边框按钮
          Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              OutlinedButton(
                child: const Text("normal"),
                onPressed: () {},
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.favorite, size: 30,),
                label: const Text('爱心'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  
                ),
              ),
            ],
          ),

          const SizedBox(height: 50,),

          // 👉 6、IconButton 是一个可点击的Icon
          IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.android),
            iconSize: 30,       // 需要通过 IconButton.iconSize设置Icon的大小，而不是Icon自身
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}