main() {
  print('t1:' + DateTime.now().toString()); 
  test();
  print('t2:' + DateTime.now().toString());
}

test() async {
  int result = await Future.delayed(const Duration(milliseconds: 2000), () {
    return Future.value(123); 
  });
  print('t3:' + DateTime.now().toString());
  print(result); 
}