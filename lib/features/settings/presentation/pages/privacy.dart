import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
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
                'سياسية الخصوصية',
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainer,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "سياسة الخصوصية",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary),                
                    ),
                    SizedBox(height: 16),
                    const Divider(
              color: Color.fromARGB(255, 236, 233, 233),
              thickness: 1,
            ),
                    SizedBox(height: 16),
                    Text(
                      "مقدمة",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "نحن نحترم خصوصية المستخدمين ونتعهد بحماية معلوماتهم الشخصية. تم تصميم سياسة الخصوصية هذه لشرح كيفية جمع واستخدام وحماية بياناتك ضمن تطبيق صوتك. إن خصوصيتك مهمة جدًا بالنسبة لنا، ولذلك نلتزم بتوفير تجربة آمنة وموثوقة لجميع مستخدمينا. نعمل على ضمان أن يتم جمع بياناتك ومعالجتها بما يتوافق مع القوانين المحلية والدولية لحماية البيانات.",
                      style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "جمع المعلومات",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "نجمع المعلومات التالية لضمان توفير تجربة آمنة ومخصصة للمستخدمين: \n"
                      "\n- المعلومات الشخصية:\n الاسم الكامل، الرقم الوطني، ورقم الهاتف.\n"
                      "\n- بيانات الاستخدام: \nمثل تفاصيل النشاط داخل التطبيق، بما في ذلك الأصوات، الاقتراحات، والتعليقات.\n"
                      "\n- معلومات الجهاز:\n مثل نوع الجهاز، نظام التشغيل، وبيانات الموقع، لضمان توافق التطبيق مع جميع الأجهزة وتحسين الأداء.",
                      style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "استخدام المعلومات",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "يتم استخدام المعلومات التي نجمعها للأغراض التالية:\n"
                      "- تحسين تجربة المستخدم من خلال تخصيص المحتوى والميزات.\n"
                      "- تعزيز الشفافية والمشاركة من خلال مشاركة الأصوات والاقتراحات مع الجهات المختصة.\n"
                      "- توفير تقارير دورية للجهات الحكومية بناءً على آراء المواطنين.\n"
                      "- التواصل مع المستخدمين بشأن تحديثات التطبيق وميزات جديدة.\n"
                      "- إجراء تحليلات لفهم سلوك المستخدمين وتحسين الخدمة.",
                      style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "مشاركة المعلومات",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "قد نشارك المعلومات مع الجهات الحكومية المعنية مثل وزارة الإدارة المحلية ووزارة الشؤون السياسية والبرلمانية لتحليل البيانات واتخاذ القرارات بناءً على آراء المستخدمين. نضمن أن تكون أي معلومات يتم مشاركتها خاضعة لإجراءات أمان صارمة، ونسعى جاهدين لحماية خصوصية بياناتك.",
                      style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "أمان المعلومات",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "نلتزم بتطبيق أعلى معايير الأمان السيبراني لحماية بيانات المستخدمين وعمليات التصويت داخل التطبيق. كما نوفر إجراءات تحقق متعددة المستويات لتأمين الحسابات ومنع أي استخدام غير مصرح به. يتم تشفير جميع البيانات الحساسة، ونقوم بإجراء مراجعات دورية لأنظمة الأمان لضمان حماية معلوماتك.",
                      style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "حقوق المستخدمين",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "لدى المستخدمين الحق في:\n"
                      "- الوصول إلى معلوماتهم الشخصية المسجلة داخل التطبيق.\n"
                      "- طلب تعديل أو حذف البيانات عند الضرورة.\n"
                      "- الإبلاغ عن أي خرق في سياسة الخصوصية.\n"
                      "- تقديم شكاوى حول كيفية استخدام بياناتهم.\n"
                      "- سحب موافقتهم على معالجة البيانات في أي وقت.",
                      style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "التغييرات في سياسة الخصوصية",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "قد يتم تعديل سياسة الخصوصية من وقت لآخر. سيتم إخطار المستخدمين بأي تغييرات جوهرية عبر إشعارات داخل التطبيق. نحن نشجعك على مراجعة هذه السياسة بانتظام لضمان فهمك لكيفية حماية معلوماتك. كما نلتزم بالإفصاح عن أي تغييرات تؤثر على كيفية جمع البيانات أو استخدامها.",
                      style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "التواصل معنا",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),
                    ),
                    SizedBox(height: 8),
                    Text(
                  "للتواصل مع فريق الدعم، يرجى إرسال بريد إلكتروني إلى support@sotalmowaten.jo أو زيارة موقعنا على الإنترنت www.sotalmowaten.jo",
                  style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.secondary),
                ),
                    SizedBox(height: 24),
                   
                    Divider(height: 32, thickness: 1),

                // Copyright
                Center(
                  child: Text(
                    "حقوق النشر © 2024 صوتك. جميع الحقوق\n محفوظة.",
                    style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.secondary),
                    textAlign: TextAlign.center,
                  ),
                ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
