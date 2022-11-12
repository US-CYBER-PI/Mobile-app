import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/models/pay_token.dart';

enum ResponseCodes { error, sms, good }

class PayViewController extends GetxController {
  RxString payToken = ''.obs;
  String host = 'https://mptdeal.ru';
  String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3MiOiJxcl9jcmVhdGUiLCJleHAiOjE2NjgyODc4NTMsImlkIjoiMiJ9.3e1OucSyA-p-raLZSi6Is7e4eCVB7xjeBHP4hBdInd4';

  d.Response? response;
  final _dio = d.Dio();
  Future<ResponseCodes> updateToken() async {
    try {
      response = await _dio.post('$host/api/v1/user/pay_token',
          options: d.Options(headers: {'Authorization': 'Bearer $token'}));

      payToken = payTokenFromJson(response?.data).token as RxString;
      return ResponseCodes.good;
      // ResponseApi.ok(message: '', data: response.data);
    } on d.DioError catch (e) {
      if (response?.statusCode == 425) {
        return ResponseCodes.sms;
      } else {
        return ResponseCodes.error;
      }
    }
  }
}
