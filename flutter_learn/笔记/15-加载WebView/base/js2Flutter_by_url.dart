import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5Js2FlutterByUrl = '''
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>通过URL向flutter传递参数</title>
</head>
<body>
	<button id="btn" style="font-size: 1em;">传递参数</button>
	<script type="text/javascript">
		var btn = document.getElementById('btn');
		btn.addEventListener('click', function () {
			document.location ="hi://webview?name=我是H5参数";
		}, false);
	</script>

</body>
</html>
''';

/// 1、JS 向 Flutter 传递数据，通过 URL 方式
class Js2flutterByUrl extends StatefulWidget {
  const Js2flutterByUrl({super.key});

  @override
  State<Js2flutterByUrl> createState() => _Js2flutterByUrlState();
}

class _Js2flutterByUrlState extends State<Js2flutterByUrl> {

  late WebViewController controller;

  get _loadBtn => FilledButton(
    onPressed: () {
      // 加载 HTML 网页
      controller.loadHtmlString(h5Js2FlutterByUrl);
    }, 
    child: const Text('加载H5', style: TextStyle(color: Colors.white),),
  );

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)    // 开启可JS执行
    ..setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (NavigationRequest request) {  // 监听 H5 中 URL 加载
        // 约定一个 H5 和 Flutter 通信协议：hi://webview
        if (request.url.startsWith('hi://webview')) {
          debugPrint('--- 处理JS传递的数据: $request');
          Uri uri = Uri.parse(request.url);
          // 解析数据
          var name = uri.queryParameters['name'];
          debugPrint('--- name = $name');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('name: $name')));
          return NavigationDecision.prevent;
        }
        debugPrint('--- 不满足通信协议, 放行加载URL');
         return NavigationDecision.navigate;
      },
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JS 通过 URL 向 Flutter 传递数据'),
        actions: [
          _loadBtn,
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}