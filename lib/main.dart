import 'package:flutter/material.dart';
import 'src/pages/main_screen.dart' show MainScreen;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const <Locale>[
        Locale('en'), // English
        Locale('ru'), // Russian
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        body: MainScreen(),
      ),
    );
  }
}
