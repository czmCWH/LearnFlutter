/*
Input widgets <https://docs.flutter.cn/ui/widgets/input>
<https://book.flutterchina.club/chapter3/input_and_form.html#_3-5-1-textfield>

1、Form
Form 是一个可选容器，用于将多个 form field Widget（例如 TextField）组合在一起。

TextFormField，一个将 TextField 小部件包装在 FormField 中的便捷小部件。

* 每个单独的 form field 都应该封装在一个 FormField 中，Form Widget 是所有这些小部件的共同祖先。
调用 FormState 上的方法来保存、重置或验证 这个 form 后代的每个 FormField。
若要获得 FormState，可以将 Form.of 与祖先为 Form 的 context 一起使用，或者将 GlobalKey 传递给 Form 构造函数并调用 GlobalKey.currentState。

* FormField 是一个抽象类，可以使用它的子类：
CupertinoTextFormFieldRow、DropdownButtonFormField、TextFormField

 */

import 'package:flutter/material.dart';

class MyForm extends StatefulWidget {

  const MyForm({ super.key });

  // 存储可变状态
  @override
  State<MyForm> createState() {
    return _MyForm();
  }
}

class _MyForm extends State<MyForm> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form 表单的使用'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,    
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: const InputDecoration( hintText: '占位文案：请输入内容', ),
                    initialValue: '初始值',
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return '底部显示校验：请输入内容';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      debugPrint('保存: $newValue');
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    //校验密码
                    validator: (v) {
                      return v!.trim().length > 5 ? null : "密码不能少于6位";
                    },
                    onSaved: (newValue) {
                      debugPrint('保存: $newValue');
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // 1、通过 GlobalKey 获取 Form 的 FormState 
                            // 如果表单有效，Validate 将返回 true
                            if (_formKey.currentState!.validate()) {
                              debugPrint('表单校验成功，数据可以用');
                              _formKey.currentState?.save();
                            }
                          },
                          child: const Text('确定1'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        // 通过 Builder 来获取 ElevatedButton 所在 widget 树的真正 context(Element) 
                        child:Builder(builder: (context){
                          return ElevatedButton(
                            child: const Text('确定2'),
                            onPressed: () {
                              // 2、通过 Form.of 获取 FormState 
                              // 由于本 widget 也是 Form 的子代 widget，所以可以通过下面 方式获取 FormState  
                              if(Form.of(context).validate()){
                                debugPrint('验证通过提交数据');
                                Form.of(context).save();
                              }
                            },
                          );
                        })
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
