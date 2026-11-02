import 'package:flutter/material.dart';
import 'pages/auth/welcomePage.dart';
import 'pages/auth/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      routes: {
        '/login' : (context) => const LoginPage(),
      },
    );
  }
}