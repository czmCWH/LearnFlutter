import 'package:flutter/material.dart';
import 'package:flutter_project/api/travel_api.dart';
import 'package:flutter_project/model/travel_tab_model.dart';
import 'package:flutter_project/widget/loading_container.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_project/widget/travel_item_widget.dart';

/// 旅拍列表页
class TravelTabPage extends StatefulWidget {
  final String groupChanneCode;

  const TravelTabPage({super.key, required this.groupChanneCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> with AutomaticKeepAliveClientMixin {

  List<TravelItem> travelItem = [];
  int pageIndex = 1;
  bool _loading = true;

  final ScrollController _scrollController = ScrollController();

  get _gridView => MasonryGridView.count(
    controller: _scrollController,
    crossAxisCount: 2, 
    itemCount: travelItem.length,
    itemBuilder: (BuildContext context, int index) => TravelItemWidget(item: travelItem[index], index: index,),
  );

  @override
  void initState() {
    _loadData();

    // 监听网格上拉
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return Scaffold(
      body: LoadingContainer(   // 下拉加载更多
        isLoading: _loading,
        child: RefreshIndicator( 
          color: Colors.blue,
          onRefresh: _loadData,
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context, 
            child: _gridView,
          ),
        ),
      ),
    );
  }

  Future<void> _loadData({loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelTabModel? model = await TravelApi.getTravels(widget.groupChanneCode, pageIndex, 10);
      List<TravelItem> items = _filterItems(model?.list);
      if (loadMore && items.isEmpty) {
        pageIndex--;
      }
      setState(() {
        if (loadMore) {
          travelItem.addAll(items);
        } else {
          travelItem = items;
        }
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      if (loadMore) {
        pageIndex--;
      }
    }
  }

  /// 移除空模型
  List<TravelItem>  _filterItems(List<TravelItem>? list) {
    if (list == null) return [];
    List<TravelItem> filterItems = [];
    for (var item in list) {
      if (item.article == null) {
        filterItems.add(item);
      }
    }
    return filterItems;
  }

  // 使用 AutomaticKeepAliveClientMixin 保证页面一直存在，避免tab切换而销毁
  @override
  bool get wantKeepAlive => true;
}