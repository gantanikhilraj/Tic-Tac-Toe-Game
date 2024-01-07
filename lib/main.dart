import 'package:flutter/material.dart';
import 'package:random_number_guess/mainscreen.dart';
import 'package:random_number_guess/multiplayer.dart';
import 'package:random_number_guess/playwithAI.dart';

void main() => runApp(const GameApp());

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic-Tac-Toe',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: MainScreen(),
      routes: {
        PalywithAI.id: (context) => const PalywithAI(),
        Multiplayer.id: (context) => const Multiplayer(),
      },
    );
  }
}
