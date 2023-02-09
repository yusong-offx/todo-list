import 'package:flutter/material.dart';

import '../main.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  Map<String, dynamic> userData = {};

  void onLoginPressed() {
    if (!loginKey.currentState!.validate()) {
      return;
    }

    // Buffer clear
    userData.clear();
  }

  void onSignUpPressed() {
    if (!loginKey.currentState!.validate()) {
      return;
    }

    // Buffer clear
    userData.clear();
  }

  @override
  Widget build(BuildContext context) {
    final size = singleton.getDeviceSize(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: size.width / 2,
          height: size.height / 3,
          child: Column(
            children: [
              Text(
                "Todo",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Form(
                child: Column(
                  children: [
                    Form(
                      key: loginKey,
                      child: Column(children: [
                        SizedBox(
                          height: 80,
                          width: 200,
                          child: TextFormField(
                            initialValue: "",
                            onSaved: (newValue) =>
                                (userData["login_id"] = newValue),
                            validator: (value) {
                              if (value == "") {
                                return "input your ID";
                              }
                              if (value!.length > 20) {
                                return "too long ID";
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              label: Text("ID"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 80,
                          width: 200,
                          child: TextFormField(
                            initialValue: "",
                            obscureText: true,
                            validator: (value) {
                              if (value == "") {
                                return "input your Password";
                              }
                              if (value!.length > 20) {
                                return "too long Password";
                              }
                              return null;
                            },
                            onSaved: ((newValue) =>
                                (userData["login_password"] = newValue)),
                            decoration: const InputDecoration(
                              label: Text("Password"),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: onLoginPressed,
                            child: const Text("login")),
                        const SizedBox(width: 5),
                        TextButton(
                            onPressed: () {}, child: const Text("sign up"))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
