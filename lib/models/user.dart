import 'dart:convert';

class UserField {
  static final List<String> values = [
    id,
    username,
    password,
  ];

  static const String tableName = "users";

  static const String id = "id";
  static const String username = "username";
  static const String password = "password";
}

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? id;
  final String username;
  final String password;

  User({
    this.id,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) =>
      User(
        id: json["id"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
}
