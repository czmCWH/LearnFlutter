import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {

  final Widget child;
  final bool isLoading;
  // true：加载指示器在浮层上显示；false：加载显示器在内部显示
  final bool cover;

  const LoadingContainer({super.key, required this.child, required this.isLoading, this.cover = false});

  get _loadingView => const Center(child: CircularProgressIndicator(color: Colors.blue,),);

  get coverView => Stack(children: [child, isLoading ? _loadingView : Container()],);

  get normalView => isLoading ? _loadingView : child;

  @override
  Widget build(BuildContext context) {
    return cover ? coverView : normalView;
  }
}