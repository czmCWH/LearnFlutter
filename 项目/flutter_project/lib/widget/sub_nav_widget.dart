import 'package:flutter/material.dart';
import 'package:flutter_project/model/home_model.dart';
import 'package:flutter_project/util/navigator_util.dart';

/// 首页-活动入口
class SubNavWidget extends StatelessWidget {
  
  final List<CommonModel>? subNavList;

  const SubNavWidget({super.key, this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  Widget? _items(BuildContext context) {
    if (subNavList == null) {
      return null;
    }
    List<Widget> items = [];
    for (var model in subNavList!) {
      items.add(_item(context, model));
    }
    
    // 计算第一行显示的数量
    int separate = (subNavList!.length / 2 + 0.5).toInt();
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        const Padding(padding: EdgeInsets.only(top: 10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(separate, subNavList!.length),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return Expanded(child: GestureDetector(
      onTap: () {
        // 跳转到 h5
        NavigatorUtil.jumpH5(
            url: model.url,
            statusBarColor: model.statusBarColor,
            title: model.title,
            hideAppBar: model.hideAppBar);
      },
      child: Column(
        children: [
          Image.network(model.icon!, width: 18, height: 18,),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(model.title!, style: const TextStyle(fontSize: 12),),
          ),
        ],
      ),
    ));
  }

}