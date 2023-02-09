import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/utils/singleton.dart';
import 'package:todo/utils/theme.dart';

late final Singleton singleton;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefInstance) {
    singleton = Singleton(pref: prefInstance);
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: singleton.theme),
      ],
      child: const MyApp(),
    ));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Todo-List',
      theme: singleton.theme.light,
      darkTheme: singleton.theme.dark,
      themeMode: context.select((MyTheme mytheme) => mytheme.mode),
      home: const Login(),
      routes: {
        "/login": (context) => const Login(),
        "/home": (context) => const MyHomePage(title: 'My Todo-List Home Page')
      },
    );
  }
}
