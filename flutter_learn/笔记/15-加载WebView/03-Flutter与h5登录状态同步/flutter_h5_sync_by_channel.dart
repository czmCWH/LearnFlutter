import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

const String channelH5Str = '''
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Flutter 通过 channel 的方式将登录状态同步给 h5</title>
</head>
<body>
	<button id="btn" style="font-size: 1em;">获取登录信息</button>
	<div id="resultText" style="font-size: 1.5em">展示Flutter传递的数据</div>
	<script type="text/javascript">
		var btn = document.getElementById('btn');
		btn.addEventListener('click', function () {
			// 通过注册的 getLoginInfo channel 向 Flutter 发送信息
			getLoginInfo.postMessage('');
		}, false);
		function hiCallJs(msg) {
			document.getElementById('resultText').innerHTML = 'Flutter传递的数据: ' + msg;
		}

	</script>
</body>
</html>
''';

class FlutterH5LoginChannel extends StatefulWidget {
  const FlutterH5LoginChannel({super.key});

  @override
  State<FlutterH5LoginChannel> createState() => _FlutterH5LoginChannelState();
}

class _FlutterH5LoginChannelState extends State<FlutterH5LoginChannel> {
  
  late WebViewController controller;

   get _loadBtn => FilledButton(
    onPressed: () {
      controller.loadHtmlString(channelH5Str);
    }, 
    child: const Text('加载H5', style: TextStyle(color: Colors.white),)
  );

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..addJavaScriptChannel('getLoginInfo', onMessageReceived: (JavaScriptMessage message) {     // 监听H5需要登录信息
      var info = {'token': 'sdfs99999', 'uid': '888888'};
      var infoStr = json.encode(info);
      controller.runJavaScript("hiCallJs('$infoStr')");     // 将登录信息传递给h5
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 通过 channel 的方式将登录状态同步给h5'),
        actions: [
          _loadBtn,
        ],
      ),
      body: WebViewWidget(controller: controller,),
    );
  }

}