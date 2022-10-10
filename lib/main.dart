import 'package:clean_app_sample/features/splash_screen/presentation/pages/splash_screen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
          //primaryColor: Colors.green.shade800,
          //accentColor: Colors.green.shade600,
          ),
      home: SplashPage(),
    );
  }
}
