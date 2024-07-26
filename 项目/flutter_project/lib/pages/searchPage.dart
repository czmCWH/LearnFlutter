
import 'package:flutter/material.dart';
import 'package:flutter_project/model/search_model.dart';
import 'package:flutter_project/util/navigator_util.dart';
import 'package:flutter_project/util/view_util.dart';
import 'package:flutter_project/widget/search_bar_widget.dart';
import 'package:flutter_project/api/search_api.dart';
import 'package:flutter_project/widget/search_item_widget.dart';

/// 搜索页面
class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String? keyword;
  final String? hint;
  const SearchPage({super.key, this.keyword, this.hint, this.hideLeft = false});

  @override
  State<SearchPage> createState() => _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {

  SearchModel? searchModel;
  String? keyword;

  get _appBar {
    // 获取刘海高度
    double top = MediaQuery.of(context).padding.top;
    return shadowWrap(
      child: Container(
        height: 55 + top,
        padding: EdgeInsets.only(top: top),
        decoration: const BoxDecoration(color: Colors.white),
        child: SearchBarWidget(
          hideLeft: widget.hideLeft, 
          hint: widget.hint, 
          defaultText: widget.keyword,
          leftButtonClick: () {
            NavigatorUtil.pop(context);
          },
          rightButtonClick: () {
            // 收起键盘
            FocusScope.of(context).requestFocus(FocusNode());
          },
          onChanged: _onTextChange,
        ),
      ),
      padding: const EdgeInsets.only(bottom: 5),
    );
  }

  get _listView => MediaQuery.removePadding(
    removeTop: true,    // 移除 ListView 默认顶部刘海间距
    context: context, 
    child: ListView.builder(
      itemCount: searchModel?.data?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _item(index);
      }
  )
  );

  @override
  void initState() {
    super.initState();
    if (widget.keyword != null) {
      setState(() {
        _onTextChange(widget.keyword!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _appBar,
          _listView,
        ],
      )
    );
  }
  
  Widget _item(int index) {
    var item = searchModel?.data?[index];
    if (searchModel == null || item == null) return Container();
    return SearchItemWidget(searchModel: searchModel!, searchItem: item);
  }

  

  void _onTextChange(String value) async {
    try {
      var result = await SearchApi.fetch(value);
      if (result == null) return;
      if (result.keyword == value) {  
        // 当输入框内容和搜索内容一致时，才渲染数据

        
      }
    } catch (e) {
      debugPrint(e.toString());
    }

  }

  

}