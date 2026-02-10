import 'package:get/get.dart';

class MainController extends GetxController {
  final _tabIndex = 0.obs;

  int get currentIndex => _tabIndex.value;

  void changeTabIndex(int index) {
    _tabIndex.value = index;
  }
}