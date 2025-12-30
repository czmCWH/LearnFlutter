import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// 我的 - 猜你喜欢 滚动吸顶组件
class ShGuess extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    // TODO: implement build
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("猜你喜欢", style: TextStyle(fontSize: 20)),
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 60;

  @override
  // TODO: implement minExtent
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return false;
  }
}
