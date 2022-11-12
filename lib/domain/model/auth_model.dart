class AuthModel {
  final String login;
  final String password;

  AuthModel({
    required this.login,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'phone': login,
      'password': password,
    };
  }

  factory AuthModel.toFromMap(Map<String, dynamic> json) {
    return AuthModel(
      login: json['login'],
      password: json['password'],
    );
  }
}
