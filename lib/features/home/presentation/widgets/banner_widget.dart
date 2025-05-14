import 'package:flutter/material.dart';

class Bannerofimage extends StatefulWidget {
  const Bannerofimage({super.key});

  @override
  State<Bannerofimage> createState() => _BannerofimageState();
}

class _BannerofimageState extends State<Bannerofimage> {
  String avatarImage = 'assets/images/home_banner_white.jpeg';

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage(avatarImage), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      child: Card(
        elevation: 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            avatarImage,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
