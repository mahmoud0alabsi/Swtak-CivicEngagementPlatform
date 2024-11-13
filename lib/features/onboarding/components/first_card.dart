import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstCard extends StatelessWidget {
  final AnimationController animationController;

  const FirstCard({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    final firstHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(1, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final headerFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(0, -2), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final headerSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final textAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final imageAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(4, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final relaxAnimation =
        Tween<Offset>(begin: const Offset(0, -2), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
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
                position: imageAnimation,
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 100, bottom: 20),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    radius: 75,
                    child: SvgPicture.asset(
                      'assets/icons/parliament_tab.svg',
                      fit: BoxFit.contain,
                      width: MediaQuery.of(context).size.width,
                      height: 110,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.surfaceContainer,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),

              SlideTransition(
                position: headerFirstHalfAnimation,
                child: SlideTransition(
                  position: headerSecondHalfAnimation,
                  child: Text(
                    "صوتك يصنع الفرق",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // SlideTransition(
              //   position: relaxAnimation,
              //   child: Text(
              //     "تحديثات الحالة الصحية",
              //     style: TextStyle(
              //       color: Theme.of(context).colorScheme.secondary,
              //       fontSize: 26,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              SlideTransition(
                position: textAnimation,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 64, right: 64, top: 16, bottom: 30),
                  child: Text(
                    "شارك في اتخاذ القرار! عبّر عن رأيك وصوّت بالموافقة أو الرفض على القضايا والمشاريع التي يناقشها مجلس النواب، وأثّر برأيك على مستقبل وطنك.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
