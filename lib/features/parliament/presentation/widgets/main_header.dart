import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainHeaderWidget extends StatelessWidget {
  const MainHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/speaker.svg',
                  width: 24,
                  height: 26,
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  'شارك في صنع القرار البرلماني',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'شارك الآن في التصويت على القرارات والقوانين التي تُناقش في البرلمان الأردني. صوتك سيساهم في توجيه أصحاب القرار نحو اتخاذ خيارات تعكس آراء المواطنين.',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
