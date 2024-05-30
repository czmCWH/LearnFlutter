import 'package:dart_learn/02-变量.dart' as dart_02;
import 'package:dart_learn/03-常量.dart' as dart_03;
import 'package:dart_learn/04-空安全和默认值.dart' as dart_04;

import 'package:dart_learn/05-数据类型/01-基本数据类型.dart' as dart_05;
import 'package:dart_learn/05-数据类型/02-Records类型.dart' as dart_Records;
import 'package:dart_learn/05-数据类型/03-集合类型-List.dart' as dart_List;
import 'package:dart_learn/05-数据类型/04-集合类型-Set.dart' as dart_Set;
import 'package:dart_learn/05-数据类型/05-集合类型-Map.dart' as dart_Map;
import 'package:dart_learn/05-数据类型/06-枚举-enum.dart' as dart_Enum;
import 'package:dart_learn/05-数据类型/07-泛型-Generics.dart' as dart_Generics;
import 'package:dart_learn/05-数据类型/08-运算符.dart' as dart_Operators;

import 'package:dart_learn/06-控制流/01-循环语句.dart' as dart_Controls;
import 'package:dart_learn/06-控制流/02-分支语句.dart' as dart_Branches;
import 'package:dart_learn/06-控制流/03-模式匹配.dart' as dart_Pattern;

import 'package:dart_learn/07-函数和异常/01-函数.dart' as dart_func;


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
  dart_Records.testRecords();
  dart_Records.testUseRecords();

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
  dart_Map.testOperatorsMap();

  print("---👇👇👇: Enum 枚举");
  dart_Enum.testEnum();

  print("---👇👇👇: Generics 泛型");
  dart_Generics.testGenerics();
  dart_Generics.testCollectGenerics();

  print("---👇👇👇: Operators运算符");
  dart_Operators.testMathOperators();
  dart_Operators.testRelationalOperators();
  dart_Operators.testTypeOperators();
  dart_Operators.testAssignmentOperators();
  dart_Operators.testLogicalOperators();
  dart_Operators.testConditionalExpr();
  dart_Operators.testCascadeOperations();
  dart_Operators.testSpreadOperations();
  dart_Operators.testOtherOperations();

  print("---👇👇👇: 流程控制语句");

  dart_Controls.testForLoops();
  dart_Controls.testWhileLoops();
  dart_Controls.testLoopsSuspend();

  print("---👇👇👇: 分支语句");
  dart_Branches.testBranchesIf();
  dart_Branches.testBranchesSwitch();

  print("---👇👇👇: 模式匹配");
  // dart_Pattern

  print("---👇👇👇: 函数");
  // dart_func



}
