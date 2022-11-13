import 'package:qiwi_mobile_app/controllers/pay_view_controller.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:qiwi_mobile_app/locator_service.dart';

class ScanController {
  d.Response? auth_token;
  final _dio = d.Dio();
  final _securedStorage = ls<FlutterSecureStorage>();

  Future<ResponseCodes> _updateToken() async {
    String? token = await _securedStorage.read(key: 'token');
    try {
      auth_token = await _dio.post(
        'https://mptdeal.ru/api/v1/auth/token',
        options: d.Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Access': 'bill',
          },
        ),
      );
      return ResponseCodes.good;
    } on d.DioError catch (e) {
      return ResponseCodes.error;
    }
  }

  Future<ResponseCodes> makeTransaction(
      String user_pay_token, int money_amount) async {
    var res = await _updateToken();
    if (res == ResponseCodes.good) {
      try {
        var formData = d.FormData.fromMap(
            {'user_pay_token': user_pay_token, 'amount': money_amount});

        auth_token = await _dio.post(
          'https://mptdeal.ru/api/v1/merchant/pay',
          data: formData,
          options: d.Options(headers: {
            'Authorization': 'Bearer ${auth_token?.data['token']}'
          }),
        );
        return ResponseCodes.good;
      } on d.DioError catch (e) {
        return ResponseCodes.error;
      }
    } else {
      return ResponseCodes.error;
    }
  }
}
