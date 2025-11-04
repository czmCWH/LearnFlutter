
import 'package:dart_learn/02-%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B/01-%E5%9F%BA%E6%9C%AC%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B.dart' as dart_05;
import 'package:dart_learn/02-%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B/type/02-Records%E7%B1%BB%E5%9E%8B.dart' as dart_Records;
import 'package:dart_learn/02-%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B/04-List%E5%88%97%E8%A1%A8.dart' as dart_List;
import 'package:dart_learn/02-%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B/type/04-%E9%9B%86%E5%90%88%E7%B1%BB%E5%9E%8B-Set.dart' as dart_Set;
import 'package:dart_learn/02-%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B/05-Map%E5%AD%97%E5%85%B8.dart' as dart_Map;
import 'package:dart_learn/02-%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B/type/06-%E6%9E%9A%E4%B8%BE-enum.dart' as dart_Enum;
import 'package:dart_learn/02-%E6%95%B0%E6%8D%AE%E7%B1%BB%E5%9E%8B/type/07-%E6%B3%9B%E5%9E%8B-Generics.dart' as dart_Generics;
import 'package:dart_learn/03-%E8%BF%90%E7%AE%97%E7%AC%A6/01-%E8%BF%90%E7%AE%97%E7%AC%A6.dart' as dart_Operators;

import 'package:dart_learn/04-%E6%8E%A7%E5%88%B6%E6%B5%81/02-%E5%BE%AA%E7%8E%AF%E8%AF%AD%E5%8F%A5.dart' as dart_Controls;
import 'package:dart_learn/04-%E6%8E%A7%E5%88%B6%E6%B5%81/01-%E5%88%86%E6%94%AF%E8%AF%AD%E5%8F%A5.dart' as dart_Branches;
import 'package:dart_learn/04-%E6%8E%A7%E5%88%B6%E6%B5%81/03-%E6%A8%A1%E5%BC%8F%E5%8C%B9%E9%85%8D.dart' as dart_Pattern;

import 'package:dart_learn/05-%E5%87%BD%E6%95%B0%E5%92%8C%E5%BC%82%E5%B8%B8/01-%E5%87%BD%E6%95%B0.dart' as dart_func;
import 'package:dart_learn/05-%E5%87%BD%E6%95%B0%E5%92%8C%E5%BC%82%E5%B8%B8/02-%E9%94%99%E8%AF%AF%E5%A4%84%E7%90%86.dart' as dart_error;

import 'package:dart_learn/08-类/01-类的基本使用.dart' as dart_baseCalss;
import 'package:dart_learn/08-类/03-extends继承.dart' as dart_extends;

import 'package:dart_learn/08-类/04-ClassModifiers/01-abstract抽象类.dart' as dart_abstract;


import 'package:dart_learn/08-类/05-Mixins混入.dart' as dart_mixinss;

import 'package:dart_learn/10-并发/02-使用Future.dart' as dart_future;




// `main` 一个特殊且 必须的 顶级函数，即程序的入口函数，`Dart` 应用程序总是会从该函数开始执行。
void main(List<String> arguments) {
  
  
  
  
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
  dart_func.foo();
  dart_func.useTestNamedParam();
  dart_func.useTestOptionalPositionParam();
  dart_func.UsePrintForItem();
  dart_func.useAnonymous();
  dart_func.testClosure();
  dart_func.usSyncGenerator();

  print("---👇👇👇: 错误处理");
  dart_error.testCatch();
  dart_error.testRethrow();
  // dart_error.testFinally();

  
  print("---👇👇👇: 类的基本使用");
  dart_baseCalss.testUseClass();
  
  print("---👇👇👇: 类的继承：");
  dart_extends.testExtensClass();

  print("---👇👇👇: 类修饰符：");
  dart_abstract.testAbastractClass();

  print("---👇👇👇: mixins混入：");
  dart_mixinss.testMixins();

  print("---👇👇👇: 异步函数：");
  dart_future.getAsynFuncResult();
  dart_future.catchAsyncFuncError();
  dart_future.testFutureAPI();
}
