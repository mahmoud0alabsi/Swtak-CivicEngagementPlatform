import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class filtercard extends StatelessWidget {
  const filtercard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.surfaceContainer,
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0.0,
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/share2.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "شارك وتصفح اخر المقترحات",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.end,
              ),
              const Spacer(),
              SvgPicture.asset(
                'assets/icons/s2.svg',
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
