import 'package:flutter/material.dart';

enum SearchBarType {
  home, // 首页默认状态下使用的样式
  normal, // 为默认情况下使用的样式
  homeLight // 首页发生上滑后使用的样式
}

/// 定义三种样式的 SearchBar
class SearchBarWidget extends StatefulWidget {
  // 是否隐藏左侧返回键
  final bool? hideLeft;
  // 搜索框类型
  final SearchBarType searchBarType;
  // 提示文案
  final String? hint;
  // 默认内容
  final String? defaultText;
  // 左右按钮点击回调
  final void Function()? leftButtonClick;
  final void Function()? rightButtonClick;
  // 输入框点击回调
  final void Function()? inputBoxClick;
  // 输入框内容变化的回调
  final ValueChanged<String>? onChanged;

  const SearchBarWidget(
      {super.key,
      this.hideLeft,
      this.searchBarType = SearchBarType.normal,
      this.hint,
      this.defaultText,
      this.leftButtonClick,
      this.rightButtonClick,
      this.inputBoxClick,
      this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {

  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  Widget get _normalSearchBar => Row(
    children: [
      // 左侧返回按钮
      _wrapTap(
        widget.leftButtonClick, 
        Padding(padding: const EdgeInsets.fromLTRB(6, 5, 10, 5), child: _backBtn, )
      ),
      // 搜索输入框
      Expanded(child: _inputBox),
      // 右侧搜索按钮
      _wrapTap(
        widget.rightButtonClick,
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text('搜索', style: TextStyle(color: Colors.blue, fontSize: 17),),
        ),
      ),
    ],
  );

  get _backBtn => widget.hideLeft ?? false ? null : const Icon(Icons.arrow_back_ios, color: Colors.grey, size: 26,);

  get _inputBox {
    Color inputBoxColor;
    if (widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white; 
    } else {
      inputBoxColor = const Color(0xffededed);
    }
    return Container(
      height: 30,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(widget.searchBarType == SearchBarType.normal ? 5 : 15),
      ),
      child: Row(
        children: [
          // 搜索按钮
          Icon(Icons.search, size: 20, color: widget.searchBarType == SearchBarType.normal ? const Color(0xffa9a9a9) : Colors.blue,),
          // 输入框
          Expanded(child: _textField),
          // 显示清除按钮
          if (showClear) _wrapTap(() {
              debugPrint('--- 点击清除');
              setState(() {
                _controller.clear();
              });
              _onChanged('');
            },  
            const Icon(Icons.clear, size: 22, color: Colors.grey)),
        ],
      ),
    );
  }

  // 首页搜索样式
  get _homeSearchBar => Row(
    children: [
      // 左边显示城市
      _wrapTap(
        widget.leftButtonClick, 
        Container(
          padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
          child: Row(
            children: [
              Text('北京', style: TextStyle(color: _homeFontColor, fontSize: 16),),
              Icon(Icons.expand_more, color: _homeFontColor, size: 22,),
            ],
          ),
        )
      ),
      // 输入框
      Expanded(child: _inputBox),
      // 登出
      _wrapTap(
        widget.rightButtonClick, 
        Padding(padding: const EdgeInsets.fromLTRB(10, 5, 10, 5), child: Text('登出', style: TextStyle(color: _homeFontColor, fontSize: 16),),)
      ),
    ],
  );

  get _homeFontColor => widget.searchBarType == SearchBarType.homeLight ? Colors.black54 : Colors.white;

  // 输入框
  get _textField => widget.searchBarType == SearchBarType.normal ? TextField(
    controller: _controller,
    onChanged: _onChanged,
    autofocus: true,
    cursorColor: Colors.blue,   // 光标的颜色
    cursorHeight: 20,
    style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300),
    // 输入框样式
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.only(left: 5,bottom: 13, right: 5),
      border: InputBorder.none,
      hintText: widget.hint,
      hintStyle: const TextStyle(fontSize: 15),
    ),
  ) : _wrapTap(widget.inputBoxClick, Text(widget.defaultText ?? '', style: const TextStyle(fontSize: 13, color: Colors.grey),));

  @override
  void initState() {
    super.initState();

    if (widget.defaultText != null) {
      _controller.text = widget.defaultText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.home ? _homeSearchBar : _normalSearchBar;
  }

  Widget _wrapTap(void Function()? callBack, Widget? child) {
    return GestureDetector(
      onTap: callBack,
      child: child,
    );
  }

  void _onChanged(String value) {
    if (value.isNotEmpty) {
      setState(() {
        showClear = true;
      });
    } else {
      setState(() {
        showClear = false;
      });
    }

    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }

  }
}
