import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shop_app/bin/test.dart';

class AuthService {
  final registrationUri = Uri.parse('http://127.0.0.1:8000/registration/');
  final loginUri = Uri.parse('http://127.0.0.1:8000/accounts/login/');
  final logoutUri = Uri.parse('http://127.0.0.1:8000/accounts/logout/');

  Future<RegistrationResponse?> registration(
      String username, String email, String password1, String password2) async {
    var response = await http.post(registrationUri, body: {
      'username': username,
      'email': email,
      'password1': password1,
      'password2': password2,
    });
    return RegistrationResponse.fromJson(jsonDecode(response.body));
  }

  Future<LoginResponse?> login(String usernameOrEmail, String password) async {
    var response = await http.post(loginUri, body: {
      'username': usernameOrEmail,
      'password': password,
    });
    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}
