import 'package:flutter/material.dart';
import 'package:weather_app/wealther_app_screen.dart';

main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: WeathwerAPPScreen(),
    );
  }
}