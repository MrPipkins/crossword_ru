import 'package:flutter/material.dart';
import 'level_select_screen.dart';

void main() {
  runApp(const CrosswordApp());
}

class CrosswordApp extends StatelessWidget {
  const CrosswordApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кроссворд',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        useMaterial3: true,
      ),
      home: const LevelSelectScreen(),
    );
  }
}
