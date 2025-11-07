import 'package:flutter/material.dart';
class HourlyForcastItemCard extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temp;
  const HourlyForcastItemCard({super.key, required this.time, required this.icon, required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card (
      child: Container(
        width: 110,
        padding: EdgeInsets.all(19),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          children: [
            Text(time,
           maxLines: 1,
            overflow: TextOverflow.ellipsis,
             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height: 8,),
            Icon(icon,size: 32,
            ),
             SizedBox(height: 8,),

            Text(temp,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}