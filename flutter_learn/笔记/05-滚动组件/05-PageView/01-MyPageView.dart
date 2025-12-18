/*
<https://api.flutter.dev/flutter/widgets/PageView-class.html>

---- 分页滚动布局

👉 1、PageView
PageView 是一页一页滚动的列表。PageView 的每个子级都必须与 viewport（视口）大小相同。
  
  构造器：
    - PageView(children: )，一次性渲染所有子项；
    - PageView.builder，按需构建大量子项；

  controller 属性，接收一个 PageController 类型，用于控制显示那个page；PageController.viewportFraction（确定页面大小占视口大小的比例）。

应用场景：
  - 轮播图；
  - 短视频上下滑动页；

 */

import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {

  // 滚动控制器
  late PageController _pageViewController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 280,
          
          child: Stack(
            children: [
              // PageView.builder，按需渲染 item
              PageView.builder(
                controller: _pageViewController,    // 滚动控制器，控制 PageView 的切换
                itemCount: 5,
                onPageChanged: (int index) {
                  debugPrint('索引 $index 发生了改变');
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text("第${index+1}项", style: const TextStyle(color: Colors.black, fontSize: 20),),
                  );
                }
              ),

              // 圆点指示器
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (int index) {
                    return GestureDetector(
                      onTap: () {
                        // 切换页面
                         _currentPageIndex = index;
                        _pageViewController.animateToPage(
                          index, 
                          duration: const Duration(milliseconds: 400), 
                          curve: Curves.easeInOut
                        );
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: index == _currentPageIndex ? Colors.red : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}