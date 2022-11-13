import 'package:intl/intl.dart';

class TokenModel {
  final String token;
  final DateTime dateTime;
  final RoleEnum role;

  TokenModel({
    required this.token,
    required this.dateTime,
    required this.role,
  });

  factory TokenModel.toFromMap(Map<String, dynamic> json) {
    return TokenModel(
        token: json['token'],
        dateTime:
            DateTime.fromMillisecondsSinceEpoch(json['expiredDate'] * 1000),
        role: RoleEnum.values
            .firstWhere((element) => element.key == json['role']));
  }
}

enum RoleEnum {
  merchant(key: 'merchant', name: 'Продавец'),
  user(key: 'user', name: 'Клиент'),
  def(key: '', name: '');

  const RoleEnum({required this.name, required this.key});

  final String key;
  final String name;
}
