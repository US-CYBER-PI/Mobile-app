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
        // dateTime: DateFormat("dd.MM.yyyy").parse(json['expiredDate'].toString()),
        role: RoleEnum.values
            .firstWhere((element) => element.name == json['role']));
  }
}

enum RoleEnum {
  merchant(name: 'merchant'),
  user(name: 'user'),
  def(name:'');

  const RoleEnum({required this.name});

  final String name;
}
