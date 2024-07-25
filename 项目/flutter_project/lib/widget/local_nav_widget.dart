import 'package:flutter/material.dart';
import 'package:flutter_project/model/home_model.dart';

/// 首页-顶部球区导航Item
class LocalNavWidget extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNavWidget({super.key, required this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 4),
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _buildItems(context),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    List<Widget> items = [];
    for (var model in localNavList) {
      items.add(_item(context, model));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }

  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        // 跳转到 h5
      },
      child: Column(
        children: [
          Image.network(model.icon!, width: 32, height: 32,),
          Text(model.title!, style: const TextStyle(color: Colors.black, fontSize: 12),),
        ],
      ),
    );
  }

}