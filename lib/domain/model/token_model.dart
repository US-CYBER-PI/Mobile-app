import 'package:intl/intl.dart';

class TokenModel {
  final String token;
  final DateTime dateTime;

  TokenModel({
    required this.token,
    required this.dateTime,
  });

  factory TokenModel.toFromMap(Map<String, dynamic> json) {
    return TokenModel(
      token: json['token'],
      dateTime: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['dateTime']),
    );
  }
}
