import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// https://geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=geekailab 内容如下：
const String cookieH5String = '''
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="utf-8">
    <title>Flutter向H5传递数据-通过URL</title>
</head>

<body>
    <button id="btn" style="font-size: 2.5em">获取数据</button>
    <button id="btnGetCookie" style="font-size: 2.5em">获取cookie</button>
    <div id="resultTxt" style="font-size: 2.5em"></button>
        <script type="text/javascript">
            //获取cookie
            var btnGetCookie = document.getElementById("btnGetCookie");
            btnGetCookie.addEventListener('click', function () {
                var cookie = document.cookie;
                document.getElementById('resultTxt').innerHTML = '获取到的cookie:' + cookie;
            }, false)
            //获取URL中的数据
            var btn = document.getElementById("btn");
            btn.addEventListener('click', function () {
                //通过URL向H5传递数据
                const params = new URLSearchParams(window.location.search);
                var name = params.get('name');
                document.getElementById('resultTxt').innerHTML = '从URL中获取到的数据:' + name;
            }, false)
        </script>
</body>

</html>
''';

/// Flutter 通过 cookie 的方式将登录状态同步给h5
class FlutterH5LoginCookie extends StatefulWidget {
  const FlutterH5LoginCookie({super.key});

  @override
  State<FlutterH5LoginCookie> createState() => _FlutterH5LoginCookieState();
}

class _FlutterH5LoginCookieState extends State<FlutterH5LoginCookie> {

  WebViewCookieManager cookieManager = WebViewCookieManager();
  late WebViewController controller;

  get _loadBtn => FilledButton(
    onPressed: () {
      controller.loadRequest(Uri.parse('https://geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=geekailab'));
    }, 
    child: const Text('加载H5', style: TextStyle(color: Colors.white),)
  );

  get _setCookieBtn => FilledButton(
    onPressed: () => _onSetCookie(context), 
    child: const Text('设置Cookie', style: TextStyle(color: Colors.white),)
  );

  get _clearCookieBtn => FilledButton(
    onPressed: () => _onClearCookie(context), 
    child: const Text('清除Cookie', style: TextStyle(color: Colors.white),)
  );

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 通过 cookie 的方式将登录状态同步给h5'),
        actions: [
          _loadBtn,
          _setCookieBtn,
          _clearCookieBtn,
        ],
      ),
      body: WebViewWidget(controller: controller,),
    );
  }

  // 设置 Cookie
  void _onSetCookie(BuildContext context) async {
    await cookieManager.setCookie(const WebViewCookie(
      name: 'token',    // 设置 Cookie 的名字
      value: 'sdfksdhkkkk888888',          // 设置 Cookie 的值
      domain: 'geekailab.com',    // 设置 Cookie 对那个域名生效
      path: '/'     // 指定域名下的路径可访问cookie，默认值为 /；如果为一个具体 path，则只有这个path下的网址才可以获取到设置的 Cookie
    ));

    // 设置多个 Cookie 的值
    await cookieManager.setCookie(const WebViewCookie(
      name: 'uid',    
      value: '99999999999',          
      domain: 'geekailab.com',    
      path: ''     
    ));

    // 测试 Cookie 是否设置成功
    final Object cookies = await controller.runJavaScriptReturningResult('document.cookie');
    debugPrint('---获取 cookies = ${cookies.toString()}');
  }

  // 清除 Cookie
  void _onClearCookie(BuildContext context) async {
    bool res = await cookieManager.clearCookies();
    debugPrint('---清除 Cookie 成功: $res');
  }

}