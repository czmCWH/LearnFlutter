import 'package:moke_xiecheng/api/login_api.dart';

hiHeaders() {
  Map<String, String> header = {
    'auth-token': 'ZmEtMjAyMS0wNC0xMaiAyMToyddMjoyMC1mYQ==ft',
    'course-flag': 'ft',
    'boarding-pass': LoginDao.getBoardingPass() ?? '',
  };
  return header;
}