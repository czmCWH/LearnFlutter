import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

/// 👉 首页 - 分类横幅
class ShCategory extends StatefulWidget {

  final List<CategoryItem> categoryList;
  const ShCategory({super.key, required this.categoryList});

  @override
  State<ShCategory> createState() => _ShCategoryState();
}

class _ShCategoryState extends State<ShCategory> {
  @override
  Widget build(BuildContext context) {
    // 返回一个横向滚动列表
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          // 获取分类数据
          final categoryItem = widget.categoryList[index];

          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(categoryItem.picture, width: 40, height: 40,),
                Text(categoryItem.name, style: const TextStyle(color: Colors.black, fontSize: 12),),
              ],
            ),
          );
        }
      ),
    );
  }
}