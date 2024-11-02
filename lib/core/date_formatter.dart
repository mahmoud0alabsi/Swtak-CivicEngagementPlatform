// Create a list of Arabic month names
List<String> arabicMonths = [
  "يناير",
  "فبراير",
  "مارس",
  "أبريل",
  "مايو",
  "يونيو",
  "يوليو",
  "أغسطس",
  "سبتمبر",
  "أكتوبر",
  "نوفمبر",
  "ديسمبر"
];

String getDateFormattedWithYear(DateTime date) {
  // Format day and month
  String formattedDate = "${date.day} ${arabicMonths[date.month - 1]}";

  // Add year if necessary
  formattedDate += " ${date.year}";

  return formattedDate;
}

String getSuggestionDateFormatted(DateTime date) {
  // Get current year
  int currentYear = DateTime.now().year;

  // Check if the year is different from the current year
  bool showYear = date.year != currentYear;

  // Format day and month
  String formattedDate = "${date.day} ${arabicMonths[date.month - 1]}";

  // Add year if necessary
  if (showYear) {
    formattedDate += " ${date.year}";
  }

  return formattedDate;
}

// Helper method to format remaining time as a string
String getRemainingTimeText(Duration remainingTime) {
  if (remainingTime.inDays > 2 && remainingTime.inDays < 11) {
    return 'متبقي ${remainingTime.inDays} أيام';
  } else if (remainingTime.inDays >= 11) {
    return 'متبقي ${remainingTime.inDays} يوم';
  } else if (remainingTime.inDays == 2) {
    return 'متبقي يومان';
  } else if (remainingTime.inDays == 1) {
    return 'متبقي يوم واحد';
  } else if (remainingTime.inHours > 1) {
    return '${remainingTime.inHours} ساعة';
  } else if (remainingTime.inHours == 1) {
    return 'ساعة واحدة';
  } else if (remainingTime.inMinutes > 1) {
    return '${remainingTime.inMinutes} دقيقة';
  } else if (remainingTime.inMinutes == 1) {
    return 'دقيقة واحدة';
  } else {
    return 'انتهت المدة';
  }
}

String getDayNameInArabic(DateTime dateTime) {
  const arabicDays = [
    'الأحد',
    'الإثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت'
  ];

  // The day index in Dart is 0 for Sunday and 6 for Saturday
  int dayIndex = dateTime.weekday % 7; // Map Sunday (7) to 0
  return arabicDays[dayIndex];
}
