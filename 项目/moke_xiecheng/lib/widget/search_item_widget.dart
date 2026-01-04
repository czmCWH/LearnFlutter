import 'package:flutter/material.dart';
import 'package:moke_xiecheng/model/search_model.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';

// 搜索结果文本中需要嵌入的图片名称
const types = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

/// 搜索List Item
class SearchItemWidget extends StatelessWidget {

  final SearchModel searchModel;
  /// 搜索模型
  final SearchItem searchItem;

  const SearchItemWidget({super.key, required this.searchItem, required this.searchModel});

  get _item => Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey)), // 下划线
    ),
    child: Row(
      children: [
        // icon
        _iconContainer,
        Column(
          children: [
            // 主标题
            SizedBox(width: 300, child: _title, ),
            // 副标题
            Container(width: 300, margin: const EdgeInsets.only(top: 5), child: _subTitle,),
          ],
        )
      ],
    ),

  );

  // 动态图标
  get _iconContainer => Container(
    margin: const EdgeInsets.all(1),
    child: Image(width: 26, height: 26, image: AssetImage(_typeImage(searchItem.type)),),
    
  );

  // 关键字富文本
  get _title {
    List<TextSpan> spans = [];
    spans.addAll(
      _keywordTextSpans(searchItem.word, searchModel.keyword ?? '')
    );
    spans.add(
      TextSpan(text: '${searchItem.districtname ?? ''} ${searchItem.zonename ?? ''}', style: const TextStyle(fontSize: 16, color: Colors.grey))
    );
    
    return RichText(text: TextSpan(children: spans));
  }

  get _subTitle =>RichText(
    text: TextSpan(
      children: [
        TextSpan(text: searchItem.price ?? '', style: const TextStyle(fontSize: 16, color: Colors.orange)),
        TextSpan(text: ' ${searchItem.star ?? ''}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ]
    )
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 跳转到 h5
        NavigatorUtil.jumpH5(url: searchItem.url, title: '详情');
      },
      child: _item,
    );
  }

  /// 根据item数据类型，返回对应的图标
  String _typeImage(String? type) {
    if (type == null) return 'images/type_travelgroup.png';
    String path = 'travelgroup';
    for (final val in types) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }
  
  // 给关键字添加富文本
  List<TextSpan> _keywordTextSpans(String? word, String keyword) {
    List<TextSpan> spans = [];
    if (word == null || word.isEmpty) return spans;
    // 搜索关键字高亮，忽略大小写
    String wordH = word.toLowerCase(), keywordH = keyword.toLowerCase();
    TextStyle normalStyle = const TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = const TextStyle(fontSize: 16, color: Colors.orange);

    // 根据关键字拆分内容
    List<String> arr = wordH.split(keywordH);
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        // 添加高亮文本
        preIndex = wordH.indexOf(keywordH, preIndex);
        spans.add(TextSpan(text: word.substring(preIndex, preIndex + keyword.length), style: keywordStyle));
      }
      // 添加非高亮文本
      String val = arr[i];
      if (val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }

    return spans;
  }

}