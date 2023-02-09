import 'package:flutter/material.dart';

import '../../main.dart';

PreferredSizeWidget myAppBar(BuildContext context, String title) {
  return AppBar(
    title: Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Text(title),
    ),
    // leading: ,
    actions: [themeModeButton(context)],
  );
}

Widget themeModeButton(BuildContext context) {
  Icon icon = singleton.theme.mode == ThemeMode.light
      ? const Icon(Icons.light_mode)
      : const Icon(Icons.dark_mode);

  void onChangeTheme() {
    singleton.theme.switchThemeMode();
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: IconButton(onPressed: onChangeTheme, icon: icon),
  );
}
