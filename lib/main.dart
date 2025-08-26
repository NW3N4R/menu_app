import 'package:flutter/material.dart';
import 'package:menu_app/custom_theme.dart';
import 'package:menu_app/pages/basketview.dart';
import 'package:menu_app/pages/home.dart';
import 'package:menu_app/pages/loading.dart';
import 'package:menu_app/pages/mealscreen.dart';
import 'package:menu_app/service/basedb.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLoaded = false;
  void get() async {
    await Store.getData();
    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getLighTheme(),
      darkTheme: getDarkTheme(),
      themeMode: ThemeMode.dark,
      home: !isLoaded ? Loading() : Home(),
      routes: {
        '/mealScreen': (context) => MealScreen(),
        '/basket': (context) => Basketview(),
      },
    );
  }
}
