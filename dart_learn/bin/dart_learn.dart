import 'package:dart_learn/02-变量.dart' as dart_02;
import 'package:dart_learn/03-常量.dart' as dart_03;
import 'package:dart_learn/04-空安全和默认值.dart' as dart_04;
import 'package:dart_learn/05-基本数据类型.dart' as dart_05;
import 'package:dart_learn/06-Records类型.dart' as dart_06;
import 'package:dart_learn/07-collections/01-集合类型-List.dart' as dart_List;
import 'package:dart_learn/07-collections/02-集合类型-Set.dart' as dart_Set;
import 'package:dart_learn/07-collections/03-集合类型-Map.dart' as dart_Map;


// `main` 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。
void main(List<String> arguments) {
  
  print("---👇👇👇: 02-变量");
  dart_02.testPrint(20);
  dart_02.testVar();
  dart_02.testExplicitlyVar();
  dart_02.testObjectVar();
  dart_02.testDynamicVar();
  dart_02.testLate();
  
  print("---👇👇👇: 03-常量");
  dart_03.testFixVar();

  print("---👇👇👇: 04-空安全和默认值");
  dart_04.testNull();
  
  print("---👇👇👇: 05-基本数据类型: int、double、String、bool");
  dart_05.testNumbers();
  dart_05.testStrings();
  dart_05.textBooleans();

  print("---👇👇👇: 06-基本数据类型: 记录(Records)");
  dart_06.testRecords();
  dart_06.testUseRecords();

  print("---👇👇👇: List 列表");
  dart_List.testList();
  dart_List.testListSpread();
  dart_List.testCreateList();
  

  print("---👇👇👇: Set 集合");
  dart_Set.testSet();
  dart_Set.testAddSet();
  dart_Set.testConstantSet();
  dart_Set.testCollectionSet();

  print("---👇👇👇: Map 字典");
  dart_Map.testMap();


}
