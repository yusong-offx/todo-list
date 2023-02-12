import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/utils/theme.dart';
import 'package:todo/utils/apiservice.dart';

class Singleton {
  final SharedPreferences pref;
  final theme = MyTheme();
  ApiService apiService = ApiService();

  Singleton({
    required this.pref,
  });

  Size getDeviceSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }
}
