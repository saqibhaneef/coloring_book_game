import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const ColoringBookApp());
}

class ColoringBookApp extends StatelessWidget {
  const ColoringBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Coloring Book',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.purple,
        scaffoldBackgroundColor: const Color(0xfffaf8ff),
      ),
      home: const HomeScreen(),
    );
  }
}
