import 'dart:convert';

PayToken payTokenFromJson(String str) => PayToken.fromJson(json.decode(str));

String payTokenToJson(PayToken data) => json.encode(data.toJson());

class PayToken {
  PayToken({
    this.token,
    this.expiredDate,
  });

  String? token;
  String? expiredDate;

  factory PayToken.fromJson(Map<String, dynamic> json) => PayToken(
        token: json["token"],
        expiredDate: json["expiredDate"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "expiredDate": expiredDate,
      };
}
