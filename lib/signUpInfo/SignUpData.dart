import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class SignUpData {
  final String username;
  final String name;
  final String email;
  final String password;

  SignUpData({required this.username, required this.name, required this.email, required this.password});

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      username: json['username'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'name': name,
      'email': email,
      'password': password,
    };
  }
}

Future<String?> checkSignUpData(String username, String email) async {
  final contents = await rootBundle.loadString('assets/db/signup_data.json');
  final decodedData = json.decode(contents);
  final jsonList = decodedData is List<dynamic> ? decodedData : [decodedData];
  final signUpDataList = jsonList.map((json) => SignUpData.fromJson(json)).toList();

  for (final signUpData in signUpDataList) {
    if (signUpData.username == username) {
      return 'Username already exists';
    }
    if (signUpData.email == email) {
      return 'Email already exists';
    }
  }

  return null;
}

Future<void> storeSignUpData(SignUpData signUpData) async {
  final signUpJson = signUpData.toJson();

  final file = File('assets/db/signup_data.json');
  await file.writeAsString(json.encode([signUpJson]));
}

/**void main() async {
  final username = 'example_user';
  final name = 'example_name';
  final email = 'example@example.com';
  final password = 'example_password';

  final error = await checkSignUpData(username, email);
  if (error != null) {
    print('Error: $error');
    return;
  }

  final signUpData = SignUpData(username: username, name: name, email: email, password: password);
  await storeSignUpData(signUpData);
  print('Sign up data stored successfully');
}**/
