import 'package:flutter/material.dart';
import 'package:random_number_guess/multiplayer.dart';
import 'package:random_number_guess/playwithAI.dart';
import 'package:random_number_guess/theme.dart';

// ignore: use_key_in_widget_constructors
class MainScreen extends StatelessWidget {
  static const String id = 'MainSCreen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              Colors.white,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Tic-Tac-Toe'),
            actions: [
              IconButton(
                icon: Icon(
                  Theme.of(context).brightness == Brightness.light
                      ? Icons.dark_mode_rounded
                      : Icons.light_mode_rounded,
                ),
                onPressed: () {
                  if (Theme.of(context).brightness == Brightness.light) {
                    DynamicTheme.of(context)!.setBrightness(Brightness.dark);
                  } else {
                    DynamicTheme.of(context)!.setBrightness(Brightness.light);
                  }
                },
              ),
            ],
          ),
          body: ListTileTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: const BorderSide(color: Colors.black),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                  child: Column(
                    children: [
                      ListTile(
                          title: const Text(
                            'Play with AI',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          leading: const Icon(
                            Icons.book_outlined,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, PalywithAI.id);
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                          title: const Text(
                            'Play with Friends',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          leading: const Icon(
                            Icons.book_outlined,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, Multiplayer.id);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
