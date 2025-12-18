/*
 👉 1、网络请求 - Dio 插件
 
 安装插件：flutter pub add dio

 一般情况下在 initState 中发送网络请求，获取页面数据。

 封装 Dio 工具类步骤：
   1、创建工具类；
   2、在构造函数中设置基础地址和超时时间；
   3、添加各类拦截器；
   4、封装统一请求方法；

 👉 2、Flutter 解决 Web 跨域问题
  默认情况下，Flutter 允许到 web 端加载网络资源会报跨域提示错误。
  本地解决办法：
    步骤1，在安装 Flutter SDK 的文件中添加配置：'--disable-web-security',
      目录为： /Library/flutter/packages/flutter_tools/lib/src/web/chrome.dart 
        ```
          '--no-first-run',
          '--no-default-browser-check',
          '--disable-default-apps',
          '--disable-translate',
          '--disable-web-security'
        ```
    步骤2，删除 /Library/flutter/bin/cache/ 目录下的快照文件：
      flutter_tools.snapshot 
      flutter_tools.stamp
    
    步骤3，执行 flutter doctor -v ，然后重新运行项目：flutter run -d chrome      

 */