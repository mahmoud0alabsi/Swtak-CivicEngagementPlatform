import 'package:flutter/material.dart';

class NotificationD {
  final DateTime dateTime;
  final String title;
  final String info; 
    late final Icon icon;
  final Category category;

  NotificationD({
    required this.dateTime,
    required this.title,
    required this.info,
    required this.category,
  }) : icon = category == Category.voicing ? Icon(Icons.celebration, color: Colors.orange) : Icon(Icons.front_hand, color: Colors.yellow[800]); 

}



  // Widget _buildIcon(String iconName) {
  //   switch (iconName) {
  //     case "d":
  //       return Icon(Icons.celebration, color: Colors.orange);
  //     case "f":
  //       return Icon(Icons.front_hand, color: Colors.yellow[800]);
  //     default:
  //       return Icon(Icons.notifications, color: Colors.grey);
  //   }



enum Category { contribution, voicing }
