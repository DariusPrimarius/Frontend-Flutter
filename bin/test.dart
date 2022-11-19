import 'dart:convert';

import 'package:http/http.dart' as http;

main() async {
  AuthService authService = AuthService();
  RegistrationResponse? registrationResponse = await authService.registration(
      'kondra1d22', 'koasdndz12aio@wp.pl', '12qwe3123', '12qwe3123');

  if (registrationResponse != null) {
    if (registrationResponse.key != null) {
      print(registrationResponse.key!);
    }
    if (registrationResponse.email != null) {
      registrationResponse.email!.forEach((element) {
        print(element);
      });
    }
    if (registrationResponse.username != null) {
      registrationResponse.username!.forEach((element) {
        print(element);
      });
    }
    if (registrationResponse.non_field_errors != null) {
      registrationResponse.non_field_errors!.forEach((element) {
        print(element);
      });
    }
    if (registrationResponse.password1 != null) {
      registrationResponse.password1!.forEach((element) {
        print(element);
      });
    }
  }
}

class AuthService {
  final registrationUri = Uri.parse('http://127.0.0.1:8000/registration/');

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
}

// Responses
// correct            - {"key":"34fd14268ee7443403ec83f34a659c36deaf6172"}
// user exist         - {"username":["A user with that username already exists."],"email":["A user is already registered with this e-mail address."]}
// password diff      - {"non_field_errors":["The two password fields didn't match."]}
// password 2 common  - {"password1":["This password is too short. It must contain at least 8 characters.","This password is too common.","This password is entirely numeric."]}
// email used         - {"email":["A user is already registered with this e-mail address."]}

class RegistrationResponse {
  List<dynamic>? key;
  List<dynamic>? username;
  List<dynamic>? non_field_errors;
  List<dynamic>? password1;
  dynamic email;

  RegistrationResponse({
    this.key,
    this.username,
    this.non_field_errors,
    this.password1,
    this.email,
  });
  factory RegistrationResponse.fromJson(mapOfBody) {
    return RegistrationResponse(
      key: mapOfBody['key'],
      username: mapOfBody['username'],
      non_field_errors: mapOfBody['non_field_errors'],
      password1: mapOfBody['password1'],
      email: mapOfBody['email'],
    );
  }
}
