import 'package:flutter/material.dart';

import 'AppTheme.dart';
import 'Pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Theme Example',
      theme: AppTheme.darkTheme,
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
