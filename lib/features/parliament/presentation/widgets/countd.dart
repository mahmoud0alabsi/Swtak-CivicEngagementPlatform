import 'dart:async';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime dateOfPost;
  final int daysOfAvailability;
  const CountdownWidget({super.key, required this.dateOfPost, required this.daysOfAvailability});

  @override
  CountdownWidgetState createState() => CountdownWidgetState();
}

class CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _timeLeft = widget.dateOfPost.add(Duration(days: widget.daysOfAvailability)).difference(DateTime.now());
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft.inSeconds > 0) {
          _timeLeft = _timeLeft - const Duration(seconds: 1);
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String days = twoDigits(duration.inDays);
    String hours = twoDigits(duration.inHours.remainder(24));
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$days:$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF1002A),
            Color(0xFFD90429),
            Color(0xFF730216),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // "العد التنازلي" aligned to the right
          const Text(
            "العد التنازلي للجولة البرلمانية",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          // "الوقت المتبقي للتصويت" aligned to the right
          const Text(
            "الوقت المتبقي للتصويت:",
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الساعات
              buildTimeBox("${_timeLeft.inSeconds.remainder(60)}", "ثانية"),
              buildSeparator(), // الثواني على اليمين
              buildTimeBox(
                  "${_timeLeft.inMinutes.remainder(60)}", "دقيقة"), // الدقائق
              buildSeparator(),
              buildTimeBox("${_timeLeft.inHours.remainder(24)}", "ساعة"),
              buildSeparator(),
              buildTimeBox("${_timeLeft.inDays}", "يوم"), // الأيام على اليسار
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "رقم جولة التصويت: 6",
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
              Text(
                "تاريخ الانتهاء: 2024-09-21",
                style: TextStyle(
                  fontSize: 8,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTimeBox(String time, String label) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1.5,
            ),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildSeparator() {
    return Transform.translate(
      offset: const Offset(0, -8), // Moves the separator up by 8 pixels
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          ":",
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.surface,
            fontWeight: FontWeight.bold, // تنسيق النقطتين
          ),
        ),
      ),
    );
  }
}
