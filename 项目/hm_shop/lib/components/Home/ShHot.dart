import 'package:flutter/material.dart';
import 'package:hm_shop/viewmodels/home.dart';

/// 👉 首页 - 爆款
class ShHot extends StatefulWidget {

  final SpecialRecommendResult result;
  final String type;

  const ShHot({super.key, required this.result, required this.type});

  @override
  State<ShHot> createState() => _ShHotState();
}

class _ShHotState extends State<ShHot> {
  // 获取前两条数据
  // 计算属性 .xxx就可以调用
  // 方法() 调用
  List<GoodsItem> get _items {
    if (widget.result.subTypes.isEmpty) {
      return [];
    }
    return widget.result.subTypes.first.goodsItems.items.take(2).toList();
  }

  // 构建子项
  List<Widget> _getChildrenList() {
    return _items.map((item) {
      return Expanded(
        child: Container(
          // width: 80,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.picture,
                  // width: 80,
                  fit: BoxFit.cover,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "lib/assets/home_cmd_inner.png",
                      // width: 80,
                      fit: BoxFit.cover,
                      height: 100,
                    );
                  },
                ),
              ),
              SizedBox(height: 5),
              Text(
                "¥${item.price}",
                style: TextStyle(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 86, 24, 20),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.type == "step" ? "一站买全" : "爆款推荐",
            maxLines: 1,
            style: TextStyle(
              color: const Color.fromARGB(255, 86, 24, 20),
              fontSize: 18,
              fontWeight: FontWeight.w700,
              
            ),
          )
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            widget.type == "step" ? "精心优选" : "最受欢迎",
            maxLines: 1,
            style: TextStyle(
              fontSize: 12,
              color: const Color.fromARGB(255, 124, 63, 58),
            ),
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: widget.type == "step"
              ? const Color.fromARGB(255, 249, 247, 219)
              : const Color.fromARGB(255, 211, 228, 240),
        ),
        child: Column(
          children: [
            // 顶部内容
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 10,
              children: _getChildrenList(),
            ),
          ],
        ),
      ),
    );
  }

}