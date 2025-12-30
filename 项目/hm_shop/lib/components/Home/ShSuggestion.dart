import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

/// 👉 首页 - 特惠推荐列表
class ShSuggestion extends StatefulWidget {

  final SpecialRecommendResult specialRecommendResult;

  const ShSuggestion({super.key, required this.specialRecommendResult});

  @override
  State<ShSuggestion> createState() => _ShSuggestionState();
}

class _ShSuggestionState extends State<ShSuggestion> {

  // 只取 父传子数据 的前3条数据显示
  List<GoodsItem> _getDisplayItems() {
    if (widget.specialRecommendResult.subTypes.isEmpty) return [];
    return widget.specialRecommendResult.subTypes.first.goodsItems.items
                .take(3)
                .toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          "特惠推荐",
          style: const TextStyle(color: Color.fromARGB(255, 86, 24, 20), fontSize: 18, fontWeight: FontWeight.w700),
        ),
        SizedBox(width: 10,),
        Text(
          "精选省攻略",
          style: const TextStyle(color: Color.fromARGB(255, 124, 63, 58), fontSize: 12),
        ),
      ],
    );
  }

  // 左侧结构
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  List<Widget> _getChildrenList() {
    List<GoodsItem> list = _getDisplayItems();
    return List.generate(list.length, (int index) {
      return Expanded(
        child: Column(
          children: [
            // 通过 ClipRRect 给图片设置圆角，而不是通过 Container 来设置
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                list[index].picture,
                // width: 80,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {  // 如果网络图片加载失败，返回一个占位图
                  return Image.asset(
                    "lib/assets/home_cmd_inner.png",
                    // width: 80,
                    height: 140,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 240, 96, 12),
              ),
              child: Text(
                "¥${list[index].price}", 
                maxLines: 1,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10), 
      child: Container(
        alignment: Alignment.center,
        // height: 300,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/assets/home_cmd_sm.png"),
            fit: BoxFit.cover
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10,),
            // 底部列表
            Row(
              children: [
                // 左边固定内容
                _buildLeft(),
                SizedBox(width: 10,),
                // 右边排列3个Item
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 10,
                    children: _getChildrenList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}