import 'package:flutter/material.dart';
import 'package:random_number_guess/main.dart';

class DynamicTheme {
  static DynamicTheme? _instance;

  DynamicTheme._();

  static DynamicTheme? of(BuildContext context) {
    _instance ??= DynamicTheme._();
    return _instance;
  }

  void setBrightness(Brightness brightness) {
    _instance = null;
    final MaterialApp app = MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
      home: const GameApp(),
    );
    runApp(app);
  }
}
