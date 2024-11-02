// import 'package:citizens_voice_app/dummydata/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

  final notifications = [
    NotificationData(
      title: 'تم تحديث البيانات',
      info: 'تم تحديث البيانات الخاصة بك بنجاح',
      dateTime: DateTime.now().subtract(const Duration(hours: 1)),
      icon: const Icon(Icons.info),
    ),
    NotificationData(
      title: 'تم تحديث البيانات',
      info: 'تم تحديث البيانات الخاصة بك بنجاح',
      dateTime: DateTime.now().subtract(const Duration(hours: 2)),
      icon: const Icon(Icons.info),
    ),
    NotificationData(
      title: 'تم تحديث البيانات',
      info: 'تم تحديث البيانات الخاصة بك بنجاح',
      dateTime: DateTime.now().subtract(const Duration(hours: 3)),
      icon: const Icon(Icons.info),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          'الإشعارات',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textDirection: TextDirection.rtl,
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              leading: //notification.icon,
                  SvgPicture.asset(
                'assets/icons/vote_now.svg',
                width: 20,
                height: 22,
              ),
              title: Text(
                notification.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(notification.info),
                  const SizedBox(height: 5),
                  Text(
                    _formatDate(notification.dateTime),
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Format date for display
String _formatDate(DateTime dateTime) {
  final duration = DateTime.now().difference(dateTime);
  if (duration.inHours > 0) {
    return "منذ ${duration.inHours} ساعات";
  } else {
    return "منذ دقيقة واحدة";
  }
}

class NotificationData {
  final String title;
  final String info;
  final DateTime dateTime;
  final Icon icon;

  NotificationData({
    required this.title,
    required this.info,
    required this.dateTime,
    required this.icon,
  });
}
