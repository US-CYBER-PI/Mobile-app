import 'package:dio/dio.dart' as d;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:qiwi_mobile_app/locator_service.dart';
import 'package:qiwi_mobile_app/models/pay_token.dart';

enum ResponseCodes { error, sms, good }

class PayViewController extends GetxController {
  RxString payToken = ''.obs;
  final securedStorage = ls<FlutterSecureStorage>();
  final _dio = d.Dio();

  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3MiOiJxcl9jcmVhdGUiLCJleHAiOjE2NjgyODc4NTMsImlkIjoiMiJ9.3e1OucSyA-p-raLZSi6Is7e4eCVB7xjeBHP4hBdInd4';

  d.Response? response;
  d.Response? auth_token;

  Future<ResponseCodes> updateToken() async {
    String? token = await securedStorage.read(key: 'token');
    try {
      var formData = d.FormData.fromMap({'Access': 'qr_create',
            'Authorization': 'Bearer $token'});

      auth_token = await _dio.post('https://mptdeal.ru/api/v1/auth/token',
          data: formData);
    } catch (e) {
      return ResponseCodes.error;
    }
    try {
      response = await _dio.post('https://mptdeal.ru/api/v1/user/pay_token',
          options: d.Options(headers: {'Authorization': 'Bearer $auth_token'}));

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
