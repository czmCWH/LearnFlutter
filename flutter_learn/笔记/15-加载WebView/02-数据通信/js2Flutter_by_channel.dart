import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5S2FlutterByChannel = '''
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>通过 javaScriptChannels 向 Flutter 传递参数</title>
</head>
<body>
	<button id="btn" style="font-size: 1em;">通过 javaScriptChannels 向 Flutter 传递参数</button>
	<script type="text/javascript">
		var btn = document.getElementById('btn');
		btn.addEventListener('click', function () {
			hiPop.postMessage('我是H5参数');
		}, false);
	</script>

</body>
</html>
''';


/// 👉 2、JS 向 Flutter 传递数据，通过 javaScriptChannel 的方式


class Js2flutterByChannel extends StatefulWidget {
  const Js2flutterByChannel({super.key});

  @override
  State<Js2flutterByChannel> createState() => _Js2flutterByChannelState();
}

class _Js2flutterByChannelState extends State<Js2flutterByChannel> {
  late WebViewController controller;

  get _loadBtn => FilledButton(
    onPressed: () {
      controller.loadHtmlString(h5S2FlutterByChannel);
    }, 
    child: const Text('加载H5', style: TextStyle(color: Colors.white),)
  );

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)  // 开启可JS执行
    ..addJavaScriptChannel('hiPop', onMessageReceived: (JavaScriptMessage message) {    // 注册并监听 JavaScriptChannel
      ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(message.message)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JS通过 向Flutter传递数据'),
        actions: [ 
          _loadBtn,
        ],
      ),
      body: WebViewWidget(controller: controller,),
    );
  }
}