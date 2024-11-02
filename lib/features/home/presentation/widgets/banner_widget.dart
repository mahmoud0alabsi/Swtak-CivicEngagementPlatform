import 'package:flutter/material.dart';

class Bannerofimage extends StatelessWidget {
  const Bannerofimage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CarouselView(
          itemExtent: double.infinity,
          itemSnapping: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          children: [
            Image.asset(
              'assets/images/home_banner_dark.jpeg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Image.asset(
              'assets/images/home_banner_white.jpeg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
        // Image.asset(
        //   'assets/images/home_banner_dark.jpeg',
        //   height: 200,
        //   width: double.infinity,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
