import 'package:flutter/material.dart';
import 'package:moke_xiecheng/model/home_model.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';

/// 首页-网格卡片布局
class GridNavWidget extends StatelessWidget {
  final GridNav gridNavModel;

  const GridNavWidget({super.key, required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      child: PhysicalModel(   // PhysicalModel 裁剪子 Widget，设置阴影效果。
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridNavItems(context),
        ),
      ),
    );
  }

  // 从上往下添加3个导航条
  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNavModel.hotel!, true));
    items.add(_gridNavItem(context, gridNavModel.flight!, false));
    items.add(_gridNavItem(context, gridNavModel.travel!, false));
    return items;
  }

  // 创建导航条，first：true是第一个导航条
  Widget _gridNavItem(BuildContext context, Hotel gridNavItem, bool first) {
    List<Widget> items = [];
    // 左侧大 item
    items.add(_mainItem(context, gridNavItem.mainItem!));
    // 添加右侧上下结构的2个item
    items.add(_doubleItem(context, gridNavItem.item1!, gridNavItem.item2!));
    items.add(_doubleItem(context, gridNavItem.item3!, gridNavItem.item4!));
    // 从左到右小item
    List<Widget> expandItems = [];
    for (var item in items) {
      expandItems.add(Expanded(flex: 1, child: item));
    }

    Color startColor = Color(int.parse('0xff${gridNavItem.startColor!}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor!}')); 

    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor]),
      ),
      child: Row(
        children: expandItems,
      ),
    );
  }

  // 创建左侧大卡片
  Widget _mainItem(BuildContext context, CommonModel model) {
    var stack = Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Image.network(
          model.icon!, 
          fit: BoxFit.contain,
          height: 88,
          width: 121,
          alignment: AlignmentDirectional.bottomEnd,
        ),
        Container(
          margin: const EdgeInsets.only(top: 11),
          child: Text(model.title!, style: const TextStyle(fontSize: 14, color: Colors.white),),
        ),
      ],
    );
    return _wrapGesture(context, stack, model);
  }

  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {
        // 跳转到 h5
        NavigatorUtil.jumpH5(url: model.url, statusBarColor: model.statusBarColor, title: model.title, hideAppBar: model.hideAppBar);
      },
      child: widget,
    );
  }

  // 创建右侧小item
  Widget _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false)),
      ],
    );
  }

  _item(BuildContext context, CommonModel item, bool first) {
    // 内容
    Widget content = Center(
      child: Text(item.title!, style: const TextStyle(fontSize: 14, color: Colors.white),),
    );
    // 分割线
    BorderSide line = const BorderSide(width: 0.8, color: Colors.white);
    // 设置带有边框的盒子
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: line,
          bottom: first ? line : BorderSide.none,
        ),
      ),
      child: _wrapGesture(context, content, item),
    );
  }

}