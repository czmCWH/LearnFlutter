import 'package:flutter/material.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// h5 容器
class HiWebView extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;

  // 禁止我的页面返回按钮
  final bool? backForbid;

  const HiWebView({super.key, this.url, this.statusBarColor, this.title, this.hideAppBar, this.backForbid});

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {

  // 主页的URL
  final _catchUrls = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5'
  ];
  String? url;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    url = widget.url;
    if (url != null && url!.contains('ctrip.com')) {
      //fix 适配携程H5 http://无法打开问题
      url = url!.replaceAll("http://", "https://");
    }
    _initWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: PopScope(   // PopScope 用于监听 Android 的物理返回键
        canPop: false,  // false：禁止 Android 物理键默认处理
        onPopInvoked: (bool didPop) async {   // 处理 Android 物理键默认处理
          if (await controller.canGoBack()) {
            // 返回 h5 的上一页
            controller.goBack();
          } else {
            // Flutter 不建议在 async 中使用 context，通过 context.mounted 判断保证 context 可以被使用，避免内存泄露
            if (context.mounted) NavigatorUtil.pop(context);
          }
        },
        child: Column(
          children: [
            _appBar(Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
            Expanded(child: WebViewWidget(    // Expanded 占满剩余空间
              controller: controller,  
            )),
          ],
        ),
      ),
    );
  }

  _initWebViewController() {
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)   // 启用js调用
    ..setBackgroundColor(const Color(0x00000000))  // 设置背景颜色
    ..setNavigationDelegate(NavigationDelegate(   // 设置代理，监听加载进度
      onProgress: (int progress) {  
        // 页面加载进度
        debugPrint('--- progress = $progress');
      },
      onPageStarted: (String url) {   // 页面开始加载
        debugPrint('--- started = $url');
      },
      onPageFinished:  (String url) {   // 页面加载完成
        // 页面加载完成之后才能执行js
        debugPrint('--- Finished = $url');
        _handleBackForbid();
      },
      onWebResourceError: (WebResourceError error) {  // 网页加载失败
        debugPrint('--- error = $error');
      },
      onNavigationRequest: (NavigationRequest request) {    // 控制网页是否可以加载
        if (_isToMain(request.url)) {
          // 跳转到 Flutter 页面
          debugPrint('阻止跳转到 $request');
          NavigatorUtil.pop(context);
          return NavigationDecision.prevent;
        }
        debugPrint('允许跳转到 $request');
        return NavigationDecision.navigate;
      },
    ))
    ..loadRequest(Uri.parse(url!));   // 开始加载网页

  }

  /// 处理 js 操作
  _handleBackForbid() {
    if (widget.backForbid ?? false) {
      // 执行js，隐藏h5中的返回按钮
      const jsStr =
          "var element = document.querySelector('.animationComponent.rn-view'); element.style.display = 'none';";
      if (widget.backForbid ?? false) {
        controller.runJavaScript(jsStr);
      }
    }
  }

  /// 判断 h5 是否返回主页
  bool _isToMain(String url) {
    bool contain = false;
    for (final value in _catchUrls) {
      if (url.endsWith(value)) {
        contain = true;
        break;
      }
    }
    return contain;
  }
  
  // 自定义 AppBar
  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    // 获取刘海屏高度
    double top = MediaQuery.of(context).padding.top;
    if (widget.hideAppBar ?? false) { 
      debugPrint('--- 隐藏导航栏= $top');
      return Container(
        color: backgroundColor,
        height: top,
      );
    }
    debugPrint('--- 显示导航栏=');
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, top, 0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            _backButton(backButtonColor),
            _title(backButtonColor),
          ],
        ),
      ),
    );

  }

  Widget _backButton(Color backButtonColor) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Icon(Icons.close, color: backButtonColor, size: 26,),
      ),
    );
  }

  Widget _title(Color backButtonColor) {
    return Positioned(
      left: 0,
      right: 0,
      child: Center(
        child: Text(widget.title ?? '', style: TextStyle(color: backButtonColor, fontSize: 20),),
      )
    );
  }

}