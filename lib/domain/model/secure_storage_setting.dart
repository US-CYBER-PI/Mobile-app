import 'package:intl/intl.dart';
import 'package:qiwi_mobile_app/domain/model/token_model.dart';

class SecureStorageSetting {
  final String token;
  final String phone;
  final DateTime dateTime;
  final RoleEnum role;

  SecureStorageSetting({
    required this.token,
    required this.phone,
    required this.dateTime,
    required this.role,
  });

  factory SecureStorageSetting.toFromMap(Map<String, String> json) {
    final date = DateTime.utc(2022);
    return SecureStorageSetting(
      token: json['token'] ?? '',
      phone: json['phone'] ?? '',
      dateTime: json.length == 0
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(
              int.parse(json['dateTime'].toString())),
      role: json['role'] == null
          ? RoleEnum.def
          : RoleEnum.values
              .firstWhere((element) => element.name == json['role']),
    );
  }
}
