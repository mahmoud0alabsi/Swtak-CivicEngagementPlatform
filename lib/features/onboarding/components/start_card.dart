import 'package:flutter/material.dart';

class StartCard extends StatefulWidget {
  final AnimationController animationController;

  const StartCard({super.key, required this.animationController});

  @override
  _StartCardState createState() => _StartCardState();
}

class _StartCardState extends State<StartCard> {
  @override
  Widget build(BuildContext context) {
    final introductionanimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: const Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: introductionanimation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          // Container(
          //   padding: const EdgeInsets.only(left: 30, right: 30, top: 170),
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     child: Image.asset(
          //       'assets/introduction_animation/introduction_image.png',
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Text(
              "استبيان",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 26,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 64, right: 64),
            child: Text(
              '"أفضل طريقة لإيصال صوتكم هو من خلال المشاركة في صنع القرار من خلال القنوات الدستورية والبرلمان"',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 64, right: 64),
            child: Text(
              'ولي العهد، 14 اكتوبر 2021 \n مؤتمر تمكين الشباب',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 16),
            child: InkWell(
              onTap: () {
                widget.animationController.animateTo(0.2);
              },
              child: Container(
                height: 58,
                padding: const EdgeInsets.only(
                  left: 56.0,
                  right: 56.0,
                  top: 16,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(38.0),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "ابدأ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
