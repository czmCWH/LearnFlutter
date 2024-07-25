import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_project/model/home_model.dart';
import 'package:flutter_project/util/navigator_util.dart';
import 'package:flutter_project/util/screen_adapter_helper.dart';

/// 首页-轮播图
class BannerWidget extends StatefulWidget {
  final List<CommonModel> bannerList;

  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  
  @override
  Widget build(BuildContext context) {

   
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CarouselSlider(
          items: widget.bannerList.map((item) => _tabImage(item, width)).toList(), 
          carouselController: _controller, 
          options: CarouselOptions(
            height: 160.px,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          ),
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
        NavigatorUtil.goToLogin();
      },
      child: Image.network(model.icon!, width: width, fit: BoxFit.cover,),
    );
  }

  _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.bannerList.asMap().entries.map((entry){
        return GestureDetector(
          child: Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(shape: BoxShape.circle, color: (Colors.white).withOpacity(_current == entry.key ? 0.9 : 0.4)),
          ),
          onTap: () => _controller.animateToPage(entry.key),
        );
      }).toList()
    );
  }

}