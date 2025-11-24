/* 
  <https://dart.cn/language/class-modifiers#sealed>

 1、sealed 密封类
  如果某个类型的子类型集是已知的，可枚举的，请使用 sealed 修饰该类。

  sealed 密封类的特点：
   - 密封类默认是抽象类，无法被实例化。
   - 密封类不允许在其自身库之外被扩展或实现。
   - 可以被 switch 选择。
 */

void main(List<String> args) {

  // 报错，无法被实例化。
  // AuthState s = AuthState();

  AuthState state = AuthFailure('错误');
  String str = testAuth(state);
  print('--- str = $str');  // --- str = AuthFailure
}

// 比如 授权状态 就具有密封类的特点，它的子类是可以确定的
sealed class AuthState{} //创建密封类

class AuthLoading extends AuthState{}

class AuthSuccess extends AuthState{
  final String user;
  final String token;

  AuthSuccess(this.user, this.token);
}

class AuthFailure extends AuthState{
  final String error;
  AuthFailure(this.error);
}


String testAuth(AuthState auth) {
  switch (auth) {
    case AuthLoading():
      return 'AuthLoading';
    case AuthSuccess():
      return 'AuthSuccess';
    case AuthFailure():
      return 'AuthFailure';
  }
}