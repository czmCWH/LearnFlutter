part of 'app_pages.dart';

/*
  1、part of 'app_pages.dart'; 表示当前文件是 app_pages.dart 文件的一部分。

  `part of` 通常放在子文件的顶部，声明这个文件属于哪个主库文件。

  2、part 'app_routes.dart'; 表示将 app_routes.dart文件包含到当前文件中。
  
    `part` 通常放在主文件的顶部，声明要包含哪些子文件。

 */

abstract class Routes {
  static const root = '/';

  static const A = "/a";
  static const one = "/one";
  static const two = "/two";
  static const three = "/three";
  static const four = "/four";

  static const B = "/b";

  static const C = "/c";
  static const cOne = "/cOne";
  static const cTwo = "/cTwo";
  static const cThree = "/cThree";

  static const D = "/d";

  static const detail = "/detail";

}