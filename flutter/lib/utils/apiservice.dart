import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  final serverURL = "localhost:3000";

  Map<String, dynamic> postlogin(Map<String, dynamic> data) {
    http
        .post(Uri.parse("$serverURL/login"),
            headers: {
              "Content-Type": "application/json",
            },
            body: jsonEncode(data))
        .then(
      (value) {
        return value;
      },
    );
  }
}
