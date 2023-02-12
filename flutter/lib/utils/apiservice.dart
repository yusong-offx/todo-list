import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/main.dart';
import 'package:todo/utils/models/todo.dart';

class ApiService {
  final serverURL = "http://yusong-offx.link";
  String? jwt;
  int? userID;

  Future<bool> postLogin(Map<String, dynamic> data) async {
    var resp = await http.post(
      Uri.parse("$serverURL/login"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );
    // Save jwt, user_id(not login_id)
    if (resp.statusCode == 200) {
      var bodydata = jsonDecode(resp.body);
      singleton.apiService.jwt = bodydata["jwt"];
      singleton.apiService.userID = bodydata["user_id"];
      return true;
    }
    return false;
  }

  Future<bool> postSignUp(Map<String, dynamic> data) async {
    var resp = await http.post(
      Uri.parse("$serverURL/signup"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(data),
    );
    if (resp.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<List<Todo>> getTodos() async {
    var resp = await http.get(
      Uri.parse("$serverURL/todo/user/$userID"),
      headers: {
        "Authorization": "Bearer $jwt",
      },
    );

    if (resp.statusCode == 200) {
      var jsonTodos = jsonDecode(resp.body);
      List<Todo> todos = [];
      for (var el in jsonTodos) {
        todos.add(Todo.fromJSON(el));
      }
      return todos;
    }
    return [];
  }

  void putDoneCheck(Map<String, dynamic> data) async {
    await http.put(
      Uri.parse("$serverURL/todo/done"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt",
      },
      body: jsonEncode(data),
    );
  }

  void postTodo(Map<String, dynamic> data) async {
    data["user_id"] = userID;
    await http.post(
      Uri.parse("$serverURL/todo"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt",
      },
      body: jsonEncode(data),
    );
  }

  void putTodo(Map<String, dynamic> data) async {
    data["user_id"] = userID;
    await http.put(
      Uri.parse("$serverURL/todo"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt",
      },
      body: jsonEncode(data),
    );
  }

  void deleteTodo(int todoID) async {
    await http.delete(
      Uri.parse("$serverURL/todo/$todoID"),
      headers: {
        "Authorization": "Bearer $jwt",
      },
    );
  }
}
