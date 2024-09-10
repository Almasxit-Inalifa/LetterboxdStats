import 'package:flutter/material.dart';
import 'package:letterboxd/Pages/Widgets/MyAppBar.dart';
import 'package:letterboxd/Pages/Widgets/enterUsername.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    void onTapSelected(int index) {}

    return Scaffold(
        appBar: MyAppBar(type: 'logo', onTap: onTapSelected, selectedIndex: 0),
        body: EnterUsername());
  }
}
