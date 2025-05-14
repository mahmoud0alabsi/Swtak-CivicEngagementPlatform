import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
              color: Theme.of(context).colorScheme.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'عن التطبيق',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textDirection: TextDirection.rtl,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Name and Version
                Text(
                  "صوتك",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 8),
                Text(
                  "الإصدار: 1.0.0",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold),
                ),

                const Divider(
                  color: Color.fromARGB(255, 236, 233, 233),
                  thickness: 1,
                ),
                const SizedBox(height: 8),
                // Purpose of the App
                buildSectionTitle("حول التطبيق", context),
                const SizedBox(height: 8),
                Text(
                  "تطبيق صوتك يهدف إلى تعزيز المشاركة الشعبية في عملية اتخاذ القرارات عبر توفير منصة رقمية تتيح للمواطنين الأردنيين التعبير عن آرائهم والتصويت على القضايا التي يناقشها البرلمان أو المشاريع المقترحة من قبل البلديات. يسعى التطبيق لتحقيق شفافية أكبر وتواصل مباشر بين المواطنين وصناع القرار.",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 24),

                // Governmental Target
                buildSectionTitle("الجهة الحكومية المستهدفة", context),
                const SizedBox(height: 8),
                Text(
                  "يستهدف التطبيق وزارة الإدارة المحلية ووزارة الشؤون السياسية والبرلمان كجهات حكومية مستفيدة من مخرجات التصويت وآراء المواطنين لمساعدتهم في اتخاذ قرارات تعكس رغبات واحتياجات الشعب.",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 24),

                // Key Features
                buildSectionTitle("مزايا التطبيق", context),
                const SizedBox(height: 8),
                Text(
                  "1. التصويت الإلكتروني: يتيح للمواطنين التصويت على القرارات والقوانين المطروحة للنقاش في مجلس النواب، مما يمنح صانعي القرار فهماً أوسع لآراء المواطنين.\n\n"
                  "2. اقتراحات المواطنين: يتيح للمستخدمين تقديم اقتراحات حول المشاريع والأفكار الجديدة التي يرغبون في تنفيذها في مناطقهم، مع إمكانية تصويت الآخرين عليها.\n\n"
                  "3. تقييم المشاريع: يسمح للمستخدمين بتقييم المشاريع الحالية في مدنهم أو محافظاتهم، مما يوفر ردود فعل مباشرة ومفيدة للسلطات المحلية لتحسين الخدمات.",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 24),

                // Usage Instructions
                buildSectionTitle("كيفية الاستخدام", context),
                const SizedBox(height: 8),
                Text(
                  "1. تسجيل الدخول: يقوم المستخدم بإنشاء حساب باستخدام الرقم الوطني وكلمة مرور.\n\n"
                  "2. عرض القضايا: يتم عرض القضايا والمشاريع الحالية ليتمكن المستخدمون من التصويت عليها أو تقديم اقتراحاتهم الخاصة.\n\n"
                  "3. التصويت والتقييم: يمكن للمستخدمين التعبير عن آرائهم وتقييم المشاريع المقترحة لتقديم تغذية راجعة مفيدة لصناع القرار.",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 24),

                // Contact Information
                buildSectionTitle("للتواصل", context),
                const SizedBox(height: 8),
                Text(
                  "للتواصل مع فريق الدعم، يرجى إرسال بريد إلكتروني إلى support@sotalmowaten.jo أو زيارة موقعنا على الإنترنت www.sotalmowaten.jo",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const SizedBox(height: 24),

                // Privacy Policy
                buildSectionTitle("سياسة الخصوصية", context),
                const SizedBox(height: 8),
                Text(
                  "يلتزم التطبيق بحماية خصوصية بيانات المستخدمين عبر سياسة صارمة لحماية المعلومات الشخصية. يمكنك الاطلاع على سياسة الخصوصية من خلال الرابط المتاح في التطبيق.",
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                const Divider(height: 32, thickness: 1),

                // Copyright
                Center(
                  child: Text(
                    "حقوق النشر © 2024 صوتك. جميع الحقوق\n محفوظة.",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build section titles with consistent style
  Widget buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
    );
  }
}
