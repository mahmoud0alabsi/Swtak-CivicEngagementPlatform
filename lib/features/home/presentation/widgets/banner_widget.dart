import 'package:flutter/material.dart';

class Bannerofimage extends StatelessWidget {
  const Bannerofimage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: Card(
        elevation: 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/home_banner_white.jpeg',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
