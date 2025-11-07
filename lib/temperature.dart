import 'package:flutter/material.dart';

class Temperature extends StatelessWidget {
  final IconData icon;
  final  String temp;
  final String number;
  const Temperature({super.key, required this.icon, required this.temp, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32,),
        SizedBox(height: 8,),
        Text(temp),
        SizedBox(height: 8,),
        Text(number, style: TextStyle(fontWeight: FontWeight.bold),),
      ],
    );
  }
}