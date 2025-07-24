import 'package:flutter/material.dart';
import 'package:omniman/homepage.dart';
import 'package:omniman/pallete.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Omni-man',
      theme: ThemeData.light(
        useMaterial3: true,
      ).copyWith(scaffoldBackgroundColor: Pallete.whiteColor),
      home: Homepage(),
    );
  }
}
