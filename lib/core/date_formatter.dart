String getSuggestionDateFormatted(DateTime date) {
  // Get current year
  int currentYear = DateTime.now().year;

  // Check if the year is different from the current year
  bool showYear = date.year != currentYear;

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

  // Format day and month
  String formattedDate = "${date.day} ${arabicMonths[date.month - 1]}";

  // Add year if necessary
  if (showYear) {
    formattedDate += " ${date.year}";
  }

  return formattedDate;
}