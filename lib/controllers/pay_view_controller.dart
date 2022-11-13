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

  d.Response? response;
  d.Response? auth_token;

  Future<ResponseCodes> updateToken() async {
    String? token = await securedStorage.read(key: 'token');
    try {
      // var formData = d.FormData.fromMap({
      //   'Access': 'qr_create',
      // });

      auth_token = await _dio.post('https://mptdeal.ru/api/v1/auth/token',
          // data: formData,
          options: d.Options(headers: {
            'Authorization': 'Bearer $token',
            'Access': 'qr_create',
          }));
    } on d.DioError catch (e) {
      return ResponseCodes.error;
    }
    try {
      response = await _dio.post('https://mptdeal.ru/api/v1/user/pay_token',
          options: d.Options(headers: {
            'Authorization': 'Bearer ${auth_token?.data['token']}'
          }));

      payToken.value =response!.data["token"].toString();
      return ResponseCodes.good;
      // ResponseApi.ok(message: '', data: response.data);
    } on d.DioError catch (e) {
      if (e.response?.statusCode == 425) {
        return ResponseCodes.sms;
      }
      return ResponseCodes.error;
    }
  }

  Future<ResponseCodes> sendSms(String sms) async {
    try {
      var formData = d.FormData.fromMap({
        'code': sms,
      });

      auth_token = await _dio.post(
        'https://mptdeal.ru/api/v1/user/phone/sms',
        data: formData,
        options: d.Options(
            headers: {'Authorization': 'Bearer ${auth_token?.data['token']}'}),
      );
      return updateToken();
    } on d.DioError catch (e) {
      return ResponseCodes.error;
    }
  }
}
