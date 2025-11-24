/*
 
 Dart 多态：是指对类的同一操作作用于不同的对象，可以产生不同的执行效果。
 多态的实现方式：
    方式1、继承和方法重写；
    方式2、抽象类和接口；
 */
void main(List<String> args) {

  // Dart 多态实现方式1 --- 子类重写父类的方法
  PayBase py = WxPay();
  py.pay();
  py = AliPay();
  py.pay();

}

class PayBase {
  void pay() {
    print('基础支付');
  }
}

class WxPay extends PayBase {
  @override
  void pay() {
    // TODO: implement pay
    // super.pay();
    print('微信支付');
  }
}

class AliPay extends PayBase {
  @override
  void pay() {
    // TODO: implement pay
    // super.pay();
    print('支付宝支付');
  }
}