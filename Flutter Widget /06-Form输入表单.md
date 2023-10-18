## TextField

[TextField](https://api.flutter.dev/flutter/material/TextField-class.html) 是 `material design` 风格的小部件。它允许用户通过硬件键盘或屏幕键盘输入文本。

每当用户更改字段中的文本时，`TextField`会调用 `onChanged` 回调。如果用户指示他们已经完成了在字段中的键入，`TextField`将调用 `OnSubmited` 回调。

`decoration` 属性控制装饰，例如添加标签或图标。默认情况下，`decoration` 属性会在文本字段下方绘制分隔符。

```Flutter
TextField(
  onChanged: (String value) {
    debugPrint("正在输入：$value");
  },
  onSubmitted: (String value) {
    debugPrint("结束输入：$value，通常在此方法中从 TextField 读取值");
  },

  keyboardType: TextInputType.phone,    // 键盘类型
  textDirection: TextDirection.rtl,     // 输入文本对齐方式
  textCapitalization: TextCapitalization.words,
  textInputAction: TextInputAction.done,        // 配置软键盘显示某种动作按钮
  style: const TextStyle(color: Colors.red, fontSize: 18),    // 输入框文本样式
  textAlign: TextAlign.center,    // 输入框文本对齐方式
  autofocus: false,   // 自动获取页面焦点，弹出键盘
  toolbarOptions: const ToolbarOptions(copy: true, cut: true, paste: true, selectAll: true),    // 长按菜单栏配置
  readOnly: true,     // 只允许读取，不允许输入
  obscureText: true,    // 是否私密显示输入内容；obscuringCharacter 属性帮助设置私密显示文本
  autocorrect: false,   // 是否自动纠正文本


  decoration: InputDecoration(    // 装饰文本框周围的样式

    icon: Icon(Icons.phone),    // 左边显示的图片
    iconColor: Colors.red,

    // label: Text("浮动label"),
    labelText: '浮动label',    // label 和 labelText 属性一样，当textField为空为输入时，显示在其中；当输入时，移动到顶部。
    labelStyle: const TextStyle(color: Colors.amberAccent, fontSize: 15),
    floatingLabelStyle: const TextStyle(color: Colors.red, fontSize: 11),   // 浮动label 对应的标签移动到顶部时，显示的样式
    floatingLabelBehavior: FloatingLabelBehavior.always,    // 浮动label 显示的行为

    helperText: "帮助文本",   // 左下方帮助文本
    errorText: "错误提示",    // 在左下方显示，和 helperText 一样

    hintText: "输入框中的占位提示文本",    // 设置了 hintText 后，则 浮动label 不显示
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 11),
    hintTextDirection: TextDirection.rtl,   // hintText 显示的方向，左边还是右边
    // isCollapsed: true,      // 是否紧凑，默认fals，该属性会影响其它属性的布局
    contentPadding: const EdgeInsets.fromLTRB(5, 10, 100, 5),    // 输入内容显示的内边距

    prefixIcon: Image.asset('assets/images/ke_nan.png'),    // 设置输入框内部前缀 Widget
    prefixIconConstraints: const BoxConstraints(maxWidth: 33),    // 前缀 Widget 布局
    prefixText: "电话号码：",  // 设置输入框前缀文本，对应属性有：prefix、prefixStyle、prefixIconColor

    border: const OutlineInputBorder(   // 其它可用类型：UnderlineInputBorder、InputDecoration
      borderSide: BorderSide(color: Colors.blue, width: 5, style: BorderStyle.solid),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      gapPadding: 10,
    ),
  ),
)
```


`controller` 属性用于控制 `TextField` 中要显示的文本，它是一个 [TextEditingController class](https://api.flutter-io.cn/flutter/widgets/TextEditingController-class.html) 。例如：可以设置 `TextField` 显示的初始值、控制选择和编辑的区域等。当不再需要 `TextEditingController` 时，记得调用的`TextEditingController.dispose`。这将确保能释放`TextField`使用的任何资源。

`TextEditingController` 也可用于为 `TextField` 提供初始值。

当用户使用关联的 `TextEditingController` 修改 `TextField` 时，`TextField` 就会更新值，`controller`会通知它的`listeners`。然后，`listeners` 可以读取 `text` 和 `selection` 属性，以了解用户键入的内容或选择内容的更新方式。

可以从添加到此 `controller` 的 `listeners` 中更新此 `controller` 的 `value`（以及`text` 和 `selection` 属性）。请注意无限循环，因为 `listeners` 也会收到来自自身的更改通知。考虑使用 [TextInputFormatter](https://api.flutter.dev/flutter/services/TextInputFormatter-class.html) 代替你键入的文本修改。

```Flutter
class FieldInputPage extends StatefulWidget {
  const FieldInputPage({Key? key}): super(key: key);

  @override
  State<FieldInputPage> createState() {
    return _FieldInputPage();
  }
}

class _FieldInputPage extends State<FieldInputPage> {

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
                  primary: Colors.black,  // 字体颜色
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
```

## FormField

[FormField](https://api.flutter-io.cn/flutter/widgets/FormField-class.html) 单个 ` form field`。维护 `form field` 的当前状态，以便更新和验证错误直观地反映在 UI 中。

在 `Form` 中使用时，可以使用 `FormState` 上的方法来查询或操作整个表单数据。例如，调用 `FormState.save` 将依次调用每个 `FormField` 的 `onSaved` 回调。

如果想检索其当前状态，请使用带 `FormField` 的 `GlobalKey`，例如，如果您希望一个表单字段依赖于另一个表单字段。

不知道怎么使用，后续补上。



## TextFormField

[TextFormField](https://api.flutter.dev/flutter/material/TextFormField-class.html) 一个将 `TextField` 小部件包装在 `FormField` 中的便利小部件。它继承自 `FormField`。

```
TextFormField(
  initialValue: "初始内容",
  decoration: const InputDecoration(
    icon: Icon(Icons.phone),    // 左边显示的图片
    iconColor: Colors.red,
    // errorText: "错误提示",
    hintText: "请输入电话号码",
    hintStyle: TextStyle(color: Colors.grey, fontSize: 11),
  ),
  keyboardType: TextInputType.phone,
  style: const TextStyle(color: Colors.black, fontSize: 15),
  onSaved: (String? value) {    // 调用 FormState.save 保存表单时使用最终值调用该回调
    debugPrint(value);
  },
  autovalidateMode: AutovalidateMode.onUserInteraction,     // 指定输入验证模式
  validator: (String? value) {  
  // 验证输入的可选方法。如果输入无效，则返回在 errorText 位置显示的错误字符串。如果不设置 errorText，则不会显示。
    debugPrint(value);
    return "3";
  },
),
```

## Form

[Form class](https://api.flutter.dev/flutter/widgets/Form-class.html) 一个可选容器，用于将多个 `form field`小部件（例如 `TextField`小部件）组合在一起。

每个单独的 `form field` 都应该包装在一个 [FormField](https://api.flutter-io.cn/flutter/widgets/FormField-class.html) 小部件中，[form](https://api.flutter-io.cn/flutter/widgets/Form-class.html) 小部件是所有这些小部件的共同祖先。

调用 [FormState class](https://api.flutter-io.cn/flutter/widgets/FormState-class.html) 上的方法来保存、重置或验证此 `Form` 的后代的每个 `FormField`。

要获取 `FormState`，可以将 `Form.of`与一个祖先为 `Form` 的 `context` 一起使用，或者将 `GlobalKey` 传递给 `Form` 构造函数并调用 `GlobalKey.currentState`。

```
class MyUseFormWidget extends StatefulWidget {
  const MyUseFormWidget({Key? key}): super(key: key);

  @override
  State<MyUseFormWidget> createState() {
    return _MyUseFormWidget();
  }
}

class _MyUseFormWidget extends State<MyUseFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: "请输入内容",
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "输入内容不允许为空";
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  debugPrint('输入内容有效！请开始其它操作');
                }
              },
              child: const Text('提交'),
            ),
          ),
        ],
      )
    );
  }
}
```