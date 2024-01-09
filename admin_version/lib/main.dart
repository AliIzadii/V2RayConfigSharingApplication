import 'package:flutter/material.dart';
import 'package:admin_version/screens/add_screen.dart';
import 'package:admin_version/utils/network.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  void initState() {
    Network.checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'v2ray',
      home: addScreen(),
    );
  }
}
