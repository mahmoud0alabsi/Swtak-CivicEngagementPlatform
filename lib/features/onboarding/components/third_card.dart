import 'package:flutter/material.dart';

class ThirdCard extends StatelessWidget {
  final AnimationController animationController;

  const ThirdCard({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final headerFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final headerSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final textAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.6,
          0.8,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final imageFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(-4, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final imageSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(4, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: firstHalfAnimation,
      child: SlideTransition(
        position: secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: headerFirstHalfAnimation,
                child: SlideTransition(
                  position: headerSecondHalfAnimation,
                  child: Text(
                    "توثيق الإجراءات الطبية",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: textAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 64, right: 64, top: 16, bottom: 16),
                  child: Text(
                    "وذلك من خلال متابعة طبية وتحديثات مستمرة حول الحالة الصحية للمريض بطريقة سهلة وسلسة ، وإطلاع ذوي المريض على التحديثات على مدار الساعة.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              // SlideTransition(
              //   position: imageFirstHalfAnimation,
              //   child: SlideTransition(
              //     position: imageSecondHalfAnimation,
              //     child: Container(
              //       constraints: const BoxConstraints(maxWidth: 350, maxHeight: 250),
              //       child: Image.asset(
              //         'assets/introduction_animation/mood_dairy_image.png',
              //         fit: BoxFit.contain,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
