// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:citizens_voice_app/theme/custom_icons.dart';
import 'package:flutter/material.dart';

class SecondCard extends StatelessWidget {
  final AnimationController animationController;

  const SecondCard({super.key, required this.animationController});

  @override
  Widget build(BuildContext context) {
    // final _firstHalfAnimation =
    //     Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
    //         .animate(CurvedAnimation(
    //   parent: animationController,
    //   curve: const Interval(
    //     0.2,
    //     0.4,
    //     curve: Curves.fastOutSlowIn,
    //   ),
    // ));
    // final _secondHalfAnimation =
    //     Tween<Offset>(begin: const Offset(0, 0), end: const Offset(1, 0))
    //         .animate(CurvedAnimation(
    //   parent: animationController,
    //   curve: const Interval(
    //     0.4,
    //     0.6,
    //     curve: Curves.fastOutSlowIn,
    //   ),
    // ));
    final _firstHalfAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
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
    final _secondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(1, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _headerFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _headerSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final textAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(2, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.4,
          0.6,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _imageFirstHalfAnimation =
        Tween<Offset>(begin: const Offset(-4, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageSecondHalfAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(4, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _imageFirstHalfAnimation,
                child: SlideTransition(
                  position: _imageSecondHalfAnimation,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 100, bottom: 20),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 75,
                      child: Icon(
                        CustomIcons.building,
                        size: 90,
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ), 
                      // SvgPicture.asset(
                      //   'assets/icons/municipality_tab.svg',
                      //   fit: BoxFit.contain,
                      //   width: MediaQuery.of(context).size.width,
                      //   height: 110,
                      //   colorFilter: ColorFilter.mode(
                      //     Theme.of(context).colorScheme.surfaceContainer,
                      //     BlendMode.srcIn,
                      //   ),
                      // ),
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _headerFirstHalfAnimation,
                child: SlideTransition(
                  position: _headerSecondHalfAnimation,
                  child: Text(
                    "رأيك يساهم في التطوير",
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
                      left: 64, right: 64, top: 16, bottom: 30),
                  child: Text(
                    "صوتك في بلديتك! صوّت على مشاريع بلديتك، وشارك بآرائك وتعليقاتك لتطوير منطقتك وتحسينها.",
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
