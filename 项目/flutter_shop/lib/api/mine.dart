import 'package:flutter_shop/utils/DioRequest.dart';
import 'package:flutter_shop/constants/index.dart';
import 'package:flutter_shop/viewmodels/home.dart';

// 猜你喜欢有参数
// page: 1 pageSize: 10
Future<GoodsDetailsItems> getGuessListAPI(Map<String, dynamic> params) async {
  return GoodsDetailsItems.formJSON(
    await dioRequest.get(HttpConstants.GUESS_LIST, params: params),
  );
}
