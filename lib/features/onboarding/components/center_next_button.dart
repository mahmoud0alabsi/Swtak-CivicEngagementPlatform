import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class CenterNextButton extends StatelessWidget {
  final AnimationController animationController;
  final VoidCallback onNextClick;
  final VoidCallback onCreateAccountClick;
  const CenterNextButton(
      {super.key,
      required this.animationController,
      required this.onNextClick,
      required this.onCreateAccountClick});

  @override
  Widget build(BuildContext context) {
    final topMoveAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final signUpMoveAnimation =
        Tween<double>(begin: 0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final loginTextMoveAnimation =
        Tween<Offset>(begin: const Offset(0, 5), end: const Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return Padding(
      padding:
          EdgeInsets.only(bottom: 24 + MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SlideTransition(
            position: topMoveAnimation,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => AnimatedOpacity(
                opacity: animationController.value >= 0.2 &&
                        animationController.value <= 0.7
                    ? 1
                    : 0,
                duration: const Duration(milliseconds: 480),
                child: _pageView(context),
              ),
            ),
          ),
          SlideTransition(
            position: topMoveAnimation,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) => Padding(
                padding: EdgeInsets.only(
                    bottom: 38 - (38 * signUpMoveAnimation.value) > 0
                        ? 38 - (38 * signUpMoveAnimation.value)
                        : 0),
                child: Container(
                  height: 58,
                  width: 58 + (200 * signUpMoveAnimation.value),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        8 + 32 * (1 - signUpMoveAnimation.value)),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: PageTransitionSwitcher(
                    duration: const Duration(milliseconds: 480),
                    reverse: signUpMoveAnimation.value < 0.7,
                    transitionBuilder: (
                      Widget child,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                    ) {
                      return SharedAxisTransition(
                        fillColor: const Color.fromARGB(0, 72, 93, 223),
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.vertical,
                        child: child,
                      );
                    },
                    child: signUpMoveAnimation.value > 0.7
                        ? InkWell(
                            key: const ValueKey('Sign Up button'),
                            onTap: onNextClick,
                            child: const Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تسجيل الدخول',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_rounded,
                                      color: Colors.white),
                                ],
                              ),
                            ),
                          )
                        : InkWell(
                            key: const ValueKey('next button'),
                            onTap: onNextClick,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.white),
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: SlideTransition(
              position: loginTextMoveAnimation,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ),
          // SlideTransition(
          //   position: topMoveAnimation,
          //   child: AnimatedBuilder(
          //     animation: animationController,
          //     builder: (context, child) => Padding(
          //       padding: EdgeInsets.only(
          //           bottom: 38 - (38 * signUpMoveAnimation.value) > 0
          //               ? 38 - (38 * signUpMoveAnimation.value)
          //               : 0),
          //       child: Container(
          //         height: 58,
          //         width: 58 + (200 * signUpMoveAnimation.value),
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(
          //               8 + 32 * (1 - signUpMoveAnimation.value)),
          //           color: Theme.of(context).primaryColor,
          //         ),
          //         child: signUpMoveAnimation.value > 0.7
          //             ? InkWell(
          //                 key: const ValueKey('Sign Up button'),
          //                 onTap: onNextClick,
          //                 child: const Padding(
          //                   padding: EdgeInsets.only(left: 16.0, right: 16.0),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                     children: [
          //                       Text(
          //                         'تسجيل الدخول',
          //                         style: TextStyle(
          //                           color: Colors.white,
          //                           fontSize: 18,
          //                           fontWeight: FontWeight.w500,
          //                         ),
          //                       ),
          //                       Icon(Icons.arrow_forward_rounded,
          //                           color: Colors.white),
          //                     ],
          //                   ),
          //                 ),
          //               )
          //             : InkWell(
          //                 key: const ValueKey('next button'),
          //                 onTap: onNextClick,
          //                 splashColor: Colors.transparent,
          //                 highlightColor: Colors.transparent,
          //                 child: const Padding(
          //                   padding: EdgeInsets.all(16.0),
          //                   child: Icon(Icons.arrow_forward_ios_rounded,
          //                       color: Colors.white),
          //                 ),
          //               ),
          //       ),
          //     ),
          //   ),
          // ),

          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => AnimatedOpacity(
              opacity: signUpMoveAnimation.value >= 0.9 ? 1 : 0,
              duration: const Duration(milliseconds: 480),
              child: Container(
                height: 58,
                width: 258,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      8 + 32 * (1 - signUpMoveAnimation.value)),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  boxShadow: [
                    BoxShadow(
                      color:
                          Theme.of(context).colorScheme.shadow.withOpacity(0.1),
                      blurRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: signUpMoveAnimation.value > 0.8
                    ? InkWell(
                        key: const ValueKey('Sign Up button'),
                        onTap: onCreateAccountClick,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'إنشاء حساب جديد',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageView(BuildContext context) {
    int selectedIndex = 0;

    if (animationController.value >= 0.9) {
      selectedIndex = 4;
    } else if (animationController.value >= 0.7) {
      selectedIndex = 3;
    } else if (animationController.value >= 0.5) {
      selectedIndex = 2;
    } else if (animationController.value >= 0.3) {
      selectedIndex = 1;
    } else if (animationController.value >= 0.1) {
      selectedIndex = 0;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.all(4),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 480),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: selectedIndex == i
                      ? Theme.of(context).primaryColor
                      : const Color(0xffE3E4E4),
                ),
                width: 10,
                height: 10,
              ),
            )
        ],
      ),
    );
  }
}
