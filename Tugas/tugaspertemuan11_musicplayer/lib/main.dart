import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const IvylodiaApp());
}

class IvylodiaApp extends StatelessWidget {
  const IvylodiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ivylodia',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111114),

        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE83D70),
          secondary: Color(0xFFC41445),
          surface: Color(0xFF19191F),
          onSurface: Color(0xFFF4F1F3),
          onSurfaceVariant: Color(0xFFA6A0A8),
          secondaryContainer: Color(0xFF351A25),
          onSecondaryContainer: Color(0xFFF4F1F3),
          outline: Color(0xFF343139),
        ),

        dividerColor: const Color(0xFF343139),
        fontFamily: 'Arial',
      ),

      home: const HomePage(),
    );
  }
}
