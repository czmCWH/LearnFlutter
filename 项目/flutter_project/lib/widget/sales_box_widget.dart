import 'package:flutter/material.dart';
import 'package:flutter_project/model/home_model.dart';

/// 首页 - 底部卡片入口
class SalesBoxWidget extends StatelessWidget {
  
  final SalesBox salesBox;
  
  const SalesBoxWidget({super.key, required this.salesBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: const BoxDecoration(color: Colors.white),
      child: _items(context),
    );
  }

  Widget _items(BuildContext context) {
    
    // 3个左右成对卡片
    List<Widget> items = [];
    items.add(_doubleItem(context, salesBox.bigCard1!, salesBox.bigCard2!, true, false));
    items.add(_doubleItem(context, salesBox.smallCard1!, salesBox.smallCard2!, false, false));
    items.add(_doubleItem(context, salesBox.smallCard3!, salesBox.smallCard4!, false, true));

    return Column(
      children: [
        _titleItem(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        ),
      ],
    );
  }

  // 顶部条
  Widget _titleItem() {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(salesBox.icon!, height: 15, fit: BoxFit.fill,),
          _moreItem(),
        ],
      ),
    );
  }

  Widget _moreItem() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
            colors: [Color(0xffff4e63), Color(0xffff6cc9)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
        ),
      ),
      child: GestureDetector(
        onTap: () {
          // 跳转到 h5
        },
        child: const Text('更多福利 >', style: TextStyle(fontSize: 12, color: Colors.white),),
      ),
    );
  }

  // 创建左右成对卡片; big 是否为打卡片；last 是否为最后一行卡片
  Widget _doubleItem(BuildContext context, CommonModel leftCard, CommonModel rightCard, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCard, big, true, last),
        _item(context, rightCard, big, false, last),
      ],
    );
  }

  /// 单个卡片
  Widget _item(BuildContext context, CommonModel model, bool big, bool left, bool last) {

    BorderSide line = const BorderSide(width: 0.8, color: Color(0xfff2f2f2));

    double itemW = MediaQuery.of(context).size.width/2 - 10;

    return GestureDetector(
      onDoubleTap: () {
        // 跳转到h5
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: left ? line : BorderSide.none,
            bottom: last ? BorderSide.none : line,
          ),
        ),
        child: Image.network(model.icon!, fit: BoxFit.fill, width: itemW, height: big ? 136 : 70,),
      ),
    );
  }
}