import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    const String appTitle = 'Material 风格的 App';

    // 一个 Material App 从 MaterialApp 小部件开始
    return MaterialApp(
      title: appTitle,  // title：窗口标题，显示在浏览器上小字。
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,   
      home: Scaffold(
        appBar: AppBar(
          title: const Text('基本组件'),
        ),
        body: const MyOrderList(),
      ),
    );
  }
}


class MyOrderList extends StatefulWidget {
  const MyOrderList({super.key});

  @override
  State<MyOrderList> createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> {

  // final boxes = [
  //   Box(key: UniqueKey(), color: Colors.blue[100]!, x: 50, y:  200),
  //   Box(key: UniqueKey(), color: Colors.blue[300]!, x: 100, y: 200),
  //   Box(key: UniqueKey(), color: Colors.blue[500]!, x: 150, y: 200),
  //   Box(key: UniqueKey(), color: Colors.blue[700]!, x: 200, y: 200),
  //   Box(key: UniqueKey(), color: Colors.blue[900]!, x: 250, y: 200),
  // ];
  final _colors = [
    Colors.blue[100]!,
    Colors.blue[300]!,
    Colors.blue[500]!,
    Colors.blue[700]!,
    Colors.blue[900]!,
  ];

  int _slot = 0; 

  // 打乱数组元素顺序
  void _shuffle() {
    setState(() {
      // boxes.shuffle();
      _colors.shuffle();
    });
  }
  
  @override
  void initState() {
    // TODO: implement initState
    _shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: (event) {
        final x = event.position.dx;
        if (x > (_slot+1)*Box.width) {
          if (_slot == _colors.length - 1) return;
          setState(() {
            final c = _colors[_slot];
            _colors[_slot] = _colors[_slot + 1];
            _colors[_slot + 1] = c;
            _slot++;
          });
        } else if (x < _slot*Box.width) {
          if (_slot == 0) return;
          setState(() {
            final c = _colors[_slot];
            _colors[_slot] = _colors[_slot - 1];
            _colors[_slot - 1] = c;
            _slot--;
          });
        }
      },
      child: Stack(
        children: List.generate(_colors.length, (int index) {
          return Box(
            key: ValueKey(_colors[index]), 
            color: _colors[index], 
            x: index*Box.width, 
            y: 200,
            onDrag: (color) {
              final index = _colors.indexOf(color);
              _slot = index;
              print("on drag index = $index");
            },
          );
        }),
      ),
    );
  } 
}

class Box extends StatelessWidget {
  static const width = 50.0;
  static const height = 50.0;
  static const magrgin = 2.0;

  final Color color;
  final double x, y;
  final Function(Color) onDrag;
  const Box({super.key, required this.color, required this.x, required this.y, required this.onDrag}); 

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 100),
      top: y,
      left: x,
      child: Draggable(
        onDragStarted: onDrag(color),
        feedback: Container(    // 被拖走后，显示的box
          color: color,
          margin: const EdgeInsets.all(magrgin),
          width: width - magrgin*2,
          height: height - magrgin*2,
        ),
        childWhenDragging: Container(   // 拖拽后，留下的占位box
          // color: color,
          margin: const EdgeInsets.all(magrgin),
          width: width - magrgin*2,
          height: height - magrgin*2,
        ),
        child: Container(
          color: color,
          margin: const EdgeInsets.all(magrgin),
          width: width - magrgin*2,
          height: height - magrgin*2,
        ),
      )
    );
  }
}