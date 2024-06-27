## TextField




```Flutter

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