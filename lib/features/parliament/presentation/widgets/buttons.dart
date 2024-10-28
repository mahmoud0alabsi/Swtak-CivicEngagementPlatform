import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VoteButton extends StatelessWidget {
  final String svgAssetPath;
  final String label;
  final List<Color> backgroundColors;
  const VoteButton({
    super.key,
    required this.svgAssetPath,
    required this.label,
    required this.backgroundColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: backgroundColors,
          center: Alignment.center,
          radius: 1.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  svgAssetPath,
                  width: 36,
                  height: 36,
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
