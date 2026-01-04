import 'package:flutter/material.dart';
import 'package:moke_xiecheng/model/travel_tab_model.dart';
import 'package:moke_xiecheng/util/navigator_util.dart';
import 'package:transparent_image/transparent_image.dart';

/// 旅拍 list 的卡片
class TravelItemWidget extends StatelessWidget {
  final TravelItem item;
  final int? index;
  
  const TravelItemWidget({super.key, required this.item, this.index});

  get _title => Container(
    padding: const EdgeInsets.all(4),
    child: Text(
          item.article?.articleTitle ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
    
  );

  get _infoText => Container(
    padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
    child: Row(
      children: [
        _avaterNickName,
        _likeIcon,
      ],
    ),
  );

  get _avaterNickName => Row(
    children: [
      // 头像
      PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: Image.network(item.article?.author?.coverImage?.dynamicUrl ?? '', width: 24, height: 24,),
      ),
      // 昵称
      Container(
        padding: const EdgeInsets.all(5),
        width: 90,
        child: Text(
          item.article?.author?.nickName ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
      )
    ],
  );

  get _likeIcon => Row(
    children: [ 
      // 点赞图标
      const Icon(Icons.thumb_up, size: 14, color: Colors.grey,),
      // 点赞数量
      Padding(
        padding: const EdgeInsets.only(left: 3),
        child: Text(
          item.article?.likeCount.toString() ?? '',
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
      )
    ],
  );


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 点击卡片，跳转到 h5
        String? url = _findJumpUrl();
        NavigatorUtil.jumpH5(url: url, title: '详情');
      },
      child: Card(    // Card 实现底部阴影和圆角效果
        child: PhysicalModel(
          color: Colors.transparent, 
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 图片
              _itemImage(context),
              // 标题
              _title,
              // 子标题
              _infoText,
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemImage(BuildContext context) {
    // 获取屏幕的 size
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // 图片
        Container(
          constraints: BoxConstraints(minHeight: size.width/2 - 10,),
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage, 
            image: item.article?.images?[0].dynamicUrl ?? '',
            fit: BoxFit.cover,
          ),
        ),
        // 地理位置标签
        Positioned(
          left: 8,
          bottom: 8,
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 1, 5, 1),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 3),
                  child: Icon(Icons.location_on, color: Colors.white, size: 12,),
                ),
                LimitedBox(
                  maxWidth: 130,
                  child: Text(_poiNmae(), maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.white, fontSize: 12),),
                )
              ],
            ),
          )
        ),
      ],
    );
  }

  String _poiNmae() {
    return item.article?.pois == null || item.article!.pois!.isEmpty ? '未知' : item.article?.pois?[0].poiName ?? '';
  }

  String? _findJumpUrl() {
    if (item.article?.urls?.isEmpty ?? false) {
      return null;
    }
    for (var url in item.article!.urls!) {
      if (url.h5Url != null) {
        return url.h5Url;
      }
    }
    return null;
  }

}