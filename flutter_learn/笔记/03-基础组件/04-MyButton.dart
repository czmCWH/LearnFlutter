/*
  1、ButtonStyleButton 的 statesController 状态管理器
  
  statesController是一个状态管理控制器，用于：
    - 管理按钮的WidgetState集合（如pressed、hovered、disabled等）
    - 向外界暴露按钮的内部状态
    - 允许自定义扩展按钮功能（如添加selected状态）
    - 通知状态变化给监听器

 */
import 'package:flutter/material.dart';

class MyListenerButtonState extends StatefulWidget {
  const MyListenerButtonState({super.key});

  @override
  State<MyListenerButtonState> createState() => _MyListenerButtonState();
}

class _MyListenerButtonState extends State<MyListenerButtonState> {
  late final MaterialStatesController _controller;
  int _stateChangeCount = 0;
  final List<String> _stateHistory = [];

  @override
  void initState() {
    super.initState();
    _controller = MaterialStatesController();
    // 添加监听器，监听 _controller 状态的改变
    _controller.addListener(_onStateChange);
  }

  void _onStateChange() {
    setState(() {
      _stateChangeCount++;
      // 记录状态变化历史
      final currentStates = _controller.value;
      _stateHistory. add('[$_stateChangeCount] 状态:  $currentStates');
      // 只保留最近10条记录
      if (_stateHistory.length > 10) {
        _stateHistory.removeAt(0);
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            '状态变化次数: $_stateChangeCount',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          // 设置 statesController 状态管理控制器，用于监听 TextButton 的状态
          TextButton(
            statesController: _controller,
            onPressed: () {},
            child: const Text('与我交互'),
          ),
        ],
      ),
    );
  }
}