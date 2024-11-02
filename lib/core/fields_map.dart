enum CommitteeType {
  legal, //قانوني
  economic, // اقتصادي
  education, // تعليمي
  sport, //  رياضي
  health, //  صحي
  agriculture, // زراعي
  transport, // نقلي
  tourism, // سياحي
}

final Map<String, String> projectFieldIcons = {
  'قانون': 'assets/icons/fields/legal.svg',
  'اقتصاد': 'assets/icons/fields/economic.svg',
  'تعليم': 'assets/icons/fields/education.svg',
  'صحة': 'assets/icons/fields/health.svg',
  'زراعة': 'assets/icons/fields/agriculture.svg',
  'نقل': 'assets/icons/fields/transport.svg',
  'سياحة': 'assets/icons/fields/tourism.svg',
};

String getProjectTypeIcon(String type) {
  return projectFieldIcons[type] ?? 'assets/icons/fields/legal.svg';
}
