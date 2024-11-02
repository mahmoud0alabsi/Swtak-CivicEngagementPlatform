import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HelpAndSupportPage extends StatelessWidget {
  final TextEditingController _concernController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
                'المساعدة والدعم الفني',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w900,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container at the top with information
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                      'assets/icons/support.svg', // Update this path with your SVG file's path
                      height: 23, // Set the desired height
                      width: 23, // Set the desired width
                      colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode
                              .srcIn), // Optionally, you can set a color if needed
                    ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'المساعدة والدعم الفني',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 23),
                      child: Text(
                        'أهلاً بك في صفحة "المساعدة والدعم"! هنا يمكنك طرح أي استفسار أو مشكلة تواجهها بخصوص خدماتنا. ما عليك سوى كتابة تفاصيل مشكلتك في حقل النص أدناه. عندما تكون جاهزًا، اضغط على زر "تقديم" لمشاركة استفسارك معنا. سنقوم بالرد عليك بأسرع وقت ممكن لمساعدتك في حل المشكلة!',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // TextField for user concerns
              _buildTextField('ادخل استفسارك أو مشكلتك هنا...', context, controller: _concernController, maxLines: 5),

              SizedBox(height: 20),

              // Submit button
SizedBox(
  width: double.infinity,
  height: 50,
  child: ElevatedButton(
    onPressed: () {
      _showConfirmationDialog(context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    child: Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..rotateY(3.14159),
            child: SvgPicture.asset(
              'assets/icons/post.svg',
              color: Theme.of(context).colorScheme.surfaceContainer,
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'تقديم',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
          ),
        ],
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

  void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          "تأكيد ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "هل أنت متأكد انك تريد الإرسال ؟",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  TextSpan(
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      //decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "تنويه",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      //decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ": ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "لن تتمكن من تعديل أو حذف رسالتك بعد إرسالها، لذا يُرجى التأكد من المحتوى قبل المتابعة.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actionsPadding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 20,
        ),
        actions: [
          _buildDialogButton(
              context, "إلغاء", Theme.of(context).colorScheme.secondary),
          // const SizedBox(width: 10),
          _buildDialogButton(
              context, "تأكيد", Theme.of(context).colorScheme.primary)
        ],
      );
    },
  );
}

Widget _buildDialogButton(BuildContext context, String label, Color color) {
  return SizedBox(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(100, 40),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.surfaceContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildTextField(String hintText, BuildContext context, {
  required TextEditingController controller, 
  int maxLines = 1,
  Color hintTextColor = Colors.grey,  // Allow hint text color customization
}) {
  return TextFormField(
    controller: controller,
    maxLines: maxLines,
    validator: (value) => value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: hintTextColor, fontSize: 15, fontWeight: FontWeight.normal),  // Custom hint text color
      filled: true,
      fillColor: Theme.of(context).colorScheme.surfaceContainer,  // Set the background color to white
      border: OutlineInputBorder( // Default border
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Color.fromARGB(255, 209, 209, 209)), // Grey border color
      ),
      enabledBorder: OutlineInputBorder( // Unfocused border
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.grey), // Grey border for unfocused state
      ),
      focusedBorder: OutlineInputBorder( // Focused border
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary), // Customize focused border color
      ),
    ),
  );
}
}