void testBranchesIf() {

  var score = 70;
  if (score > 60 && score <= 70) {
    print('---及格');
  } else if (score > 70 && score <= 80) {
    print('---一般');
  } else if (score > 80 && score <= 90) {
    print('---不错');
  } else if (score > 90){
    print('---优秀');
  }
  
  /* 
   * if 语句支持 case 子句后跟一个模式。支持 dart 3.0+
   * 如果模式与值匹配，则分支将使用模式在范围内定义的任何变量执行。
   */

  (int, bool) r1 = (10, false);
  if (r1 case (int a, bool b)) {
    print('a = $a, b = $b');      // 打印：a = 10, b = false
  }

}

void testBranchesSwitch() {

  print('--- switch 语句');
  
  var str = "aaa";
  
  switch (str) {     // 打印：aaa
    case 'aaa':
      print('--- aaa');
    case 'bbb':
      print('--- bbb');
    case 'ccc':
      print('--- ccc');
    case 'ddd':
      print('--- ddd');
    default:
      print('--- no no no');
  }

  // 对于非连续穿透的 case，可以使用continue语句和标签：
  switch (str) {    // 打印：aaa、ddd
    case 'aaa':
      print('--- aaa');
      continue newCase;
    case 'bbb':
      print('--- bbb');
    case 'ccc':
      print('--- ccc');
      newCase:
    case 'ddd':
      print('--- ddd');
    default:
      print('--- no no no');
  }

}