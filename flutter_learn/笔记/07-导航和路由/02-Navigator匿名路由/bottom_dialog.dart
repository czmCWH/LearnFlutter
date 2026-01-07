import 'package:flutter/material.dart';

class BottomDialog extends StatelessWidget {

  final String title;
  final String message;

  const BottomDialog({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        decoration: BoxDecoration(    // 设置圆角背景
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        width: double.infinity,   // 宽度 = 屏幕宽
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,   // 高度随内容自适应
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12),
              Text(
                message,
                style: TextStyle(fontSize: 15,),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Theme.of(context).dividerColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                        foregroundColor: Theme.of(context).textTheme.labelLarge?.color,
                      ),
                      onPressed: () {
                        Navigator.pop(context, "点击了取消");
                      },
                      child: Text("取消"),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context, "点击了确认");
                      },
                      child: Text("确认"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}