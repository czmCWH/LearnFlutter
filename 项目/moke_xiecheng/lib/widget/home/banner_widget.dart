import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:moke_xiecheng/model/home_model.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';
import 'package:moke_xiecheng/util/screen_adapter_helper.dart';

/// 首页-轮播图
class BannerWidget extends StatefulWidget {
  final List<CommonModel> bannerList;

  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CarouselSlider(
          items: widget.bannerList.map((item) => _tabImage(item, width)).toList(),  // 轮播组件列表
          options: CarouselOptions(
            height: 160.px,
            autoPlay: true,
            viewportFraction: 1.0,  // 视口百分比
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
          carouselController: _controller,  // 轮播控制器
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: _indicator(),
        ),
      ],
    );
  }

  Widget _tabImage(CommonModel model, double width) {
    return GestureDetector(
      onTap: () {
        // NavigatorUtil.goToLogin();
        NavigatorUtil.jumpH5(url: model.url,title: model.title, hideAppBar: model.hideAppBar);
      },
      child: Image.network(model.icon!, width: width, fit: BoxFit.cover,),
    );
  }

  _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // 把 bannerList 数组转换为 以索引为 key，元素值为 value 的 Map
      // entry 是转化后的 Map 项
      children: widget.bannerList.asMap().entries.map((entry){
        return GestureDetector(
          child: Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle, 
              color: (Colors.white).withOpacity(_current == entry.key ? 0.9 : 0.4)
            ),
          ),
          onTap: () => _controller.animateToPage(entry.key),
        );
      }).toList()
    );
  }

}