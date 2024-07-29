import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5Flutter2JsByrunJavaScript = '''
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Flutter 通过 runJavaScript 向 H5 传递数据</title>
	<script type="text/javascript">
		function hiCallJs(msg) {
			document.getElementById('resultTxt').innerHTML = 'Flutter传递的数据: ' + msg;
		}
		function hiCallJsWithResult(v1, v2) {
			return parseInt(v1) + parseInt(v2);
		}
	</script>
</head>
<body>
	<div id='resultTxt' style="font-size: 1em;">展示Flutter传递过来的数据</div>
</body>
</html>
''';


class Flutter2jsByRunjs extends StatefulWidget {
  const Flutter2jsByRunjs({super.key});

  @override
  State<Flutter2jsByRunjs> createState() => _Flutter2jsByRunjsState();
}

class _Flutter2jsByRunjsState extends State<Flutter2jsByRunjs> {

  late WebViewController controller;

  get _loadBtn => FilledButton(
    onPressed: () {
     controller.loadHtmlString(h5Flutter2JsByrunJavaScript);
    }, 
    child: const Text('加载H5', style: TextStyle(color: Colors.white),)
  );

  get _fireData => FilledButton(
    onPressed: () async {
      var name = 'Flutter 的参数';
      // 注意：执行 runJavaScript 时，必须在 H5 加载完毕，否则会报错：Failed evaluating JavaScript；
      //      如果传递的参数是动态的，则需要对参数加单引号；
      controller.runJavaScript("hiCallJs('$name')");

      var result = await controller.runJavaScriptReturningResult("hiCallJsWithResult(11, 22)");
      debugPrint('--- js 计算结果 = $result');
    },  
    child: const Text('传递数据', style: TextStyle(color: Colors.white),)
  );

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);  // 开启可JS执行
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 通过 runJavaScript 向 H5 传递数据'),
        actions: [
          _loadBtn,
          _fireData,
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}