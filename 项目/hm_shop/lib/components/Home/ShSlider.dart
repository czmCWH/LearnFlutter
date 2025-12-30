import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:hm_shop/viewmodels/home.dart';

/*
  1、安装轮播图组件
   flutter pub add carousel_slider 
 */

/// 👉 首页 - 轮播图组件
class ShSlider extends StatefulWidget {

  final List<BannerItem> bannerList;

  const ShSlider({super.key, required this.bannerList});

  @override
  State<ShSlider> createState() => _ShSliderState();
}

class _ShSliderState extends State<ShSlider> {

  // 控制轮播图切换
  final CarouselSliderController _carouselController = CarouselSliderController();
  // 当前显示轮播的索引
  int _currentIndex = 0;

  // 轮播图
  Widget _getSlider() {
    /// ⚠️ 获取屏幕宽度
    final double screenWidth = MediaQuery.of(context).size.width;

    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }), 
      options: CarouselOptions(
        viewportFraction: 1.0,  // 视口占比
        autoPlay: true,
        height: 300,
        autoPlayInterval: Duration(seconds: 2),
        onPageChanged: (int index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      carouselController: _carouselController,
    );
  }
  
  // 顶部搜索条
  Widget _getSerach() {
    return Positioned(
      top: MediaQuery.of(context).padding.top,    // 👉 适配顶部安全距离
      left: 10,
      right: 10,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text("请输入搜索内容", style: const TextStyle(color: Colors.white, fontSize: 16),),
        ),
      ),
    );
  }

  // 轮播指示器
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                // _carouselController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                _carouselController.jumpToPage(index);
              },
              // ⚠️，AnimatedContainer 是 Container 的动画组件，只要修改其属性值，会自带动画效果。
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: index == _currentIndex ? 40 : 20,
                height: 6,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: index == _currentIndex ? Colors.white: Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            );
          }),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack 层叠组件 -> 轮播图、搜索框、指示灯导航
    return Stack(
      children: [
        _getSlider(),
        _getSerach(),
        _getDots(),
      ],
    );
  }
}