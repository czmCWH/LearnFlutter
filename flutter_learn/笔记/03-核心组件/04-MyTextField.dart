/* 
Input widgets <https://docs.flutter.cn/ui/widgets/input>

1、TextField
TextField 一个 Material Design 的 Widget。
要将 TextField 集成到 From 中，请使用 TextFormField。

它的属性有：

* InputDecoration? decoration
  TextField 有一个 decoration ，默认在文本字段下方绘制分隔符的装饰。
  如果 decoration 为 null，则装饰将被完全移除。

* TextEditingController? controller
  用于控制 TextField 中要显示的文本。例如：设置初始值；控制选择和撰写区域(并观察文本、选择和撰写区域的更改)。
  当不再需要 TextEditingController 时，请记住调用 TextEditingController.dispose。这将确保能释放 TextField 使用的任何资源。


 */

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  const MyTextField({Key? key}): super(key: key);

  @override
  State<MyTextField> createState() {
    return _MyTextField();
  }
}

class _MyTextField extends State<MyTextField> {

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // 1、通过 controler 属性配置 textField 的默认值
    _controller = TextEditingController(text: "初始值");

    // 2、添加 listeners，只能输入大写字符串
    _controller.addListener(() {
      final String text = _controller.text.toUpperCase();
      _controller.value = _controller.value.copyWith(
        text: text,
        selection: TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
      debugPrint("=====czm, ${_controller.text}");
    });
  }

  @override
  void dispose() {
    // 3、释放controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('输入框')),
        body: Center(
          child: Column(
            children: [
              // 1、TextField 的基本使用
              TextField(
                onChanged: (String value) {
                  debugPrint("正在输入：$value");
                },
                onSubmitted: (String value) {
                  debugPrint("结束输入：$value，通常在此方法中从 TextField 读取值");
                },

                keyboardType: TextInputType.phone,    // 键盘类型
                textDirection: TextDirection.ltr,     // 输入文本对齐方式
                textCapitalization: TextCapitalization.words,   // 配置大写键盘
                textInputAction: TextInputAction.done,        // 配置软键盘显示某种动作按钮
                style: const TextStyle(color: Colors.red, fontSize: 18),    // 输入框文本样式
                textAlign: TextAlign.left,    // 输入框文本对齐方式
                autofocus: false,   // 自动获取页面焦点，弹出键盘
                toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),    // 长按菜单栏配置
                readOnly: false,     // 只允许读取，不允许输入
                obscureText: false,    // 是否私密显示输入内容；obscuringCharacter 属性帮助设置私密显示文本
                autocorrect: false,   // 是否自动纠正文本

                decoration: InputDecoration(    // 装饰文本框周围的样式

                  icon: Icon(Icons.phone),    // 左边显示的图片
                  iconColor: Colors.red,

                  // label: Text("浮动label"),
                  labelText: '浮动label',    // label 和 labelText 属性一样，当textField为空为输入时，显示在其中；当输入时，移动到顶部。
                  labelStyle: const TextStyle(color: Colors.amberAccent, fontSize: 25),
                  floatingLabelStyle: const TextStyle(color: Colors.red, fontSize: 11),   // 浮动label 对应的标签移动到顶部时，显示的样式
                  floatingLabelBehavior: FloatingLabelBehavior.always,    // 浮动label 显示的行为

                  helperText: "帮助文本",   // 左下方帮助文本
                  errorText: "错误提示",    // 在左下方显示，和 helperText 一样

                  hintText: "输入框中的占位提示文本",    // 设置了 hintText 后，则 浮动label 不显示
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 11),
                  hintTextDirection: TextDirection.rtl,   // hintText 显示的方向，左边还是右边
                  // isCollapsed: true,      // 是否紧凑，默认fals，该属性会影响其它属性的布局
                  contentPadding: const EdgeInsets.fromLTRB(5, 10, 100, 5),    // 输入内容显示的内边距

                  prefixIcon: Image.asset('images/phone.png'),    // 设置输入框内部前缀 Widget
                  prefixIconConstraints: const BoxConstraints(maxWidth: 33),    // 前缀 Widget 布局
                  prefixText: "电话号码：",  // 设置输入框前缀文本，对应属性有：prefix、prefixStyle、prefixIconColor

                  border: const OutlineInputBorder(   // 其它可用类型：UnderlineInputBorder、InputDecoration
                    borderSide: BorderSide(color: Colors.blue, width: 5, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    gapPadding: 10,
                  ),
                ),
              ),

              // 2、控制 TextField 的文本显示

              TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '请输入密码',
                ),
              ),
              TextButton(
                onPressed: () {
                  // 通过controller修改textField的值
                  _controller.text = "";
                },
                child: const Text('重置'),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  foregroundColor: Colors.black,  // 字体颜色
                  textStyle: const TextStyle(fontSize: 15),
                  backgroundColor: Colors.orange.withOpacity(0.5),   // 背景颜色
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}