import 'package:flutter/material.dart';

import 'reset_password_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController phoneController =
      TextEditingController(); // Controller for the phone text field

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'نسيت الرقم السري',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),
            Text(
              'يرجى إدخال رقم هاتفك لإعادة تعيين كلمة المرور',
              style: TextStyle(
                  fontSize: 16, color: Theme.of(context).colorScheme.secondary),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 30),
            Text(
              "رقم الهاتف",
              style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                  hintText: 'XX XXX XX4 76',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF9E9E9E))),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey), // Unfocused border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    // Focused border color
                  )),
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))
                  // match_parent width, fixed height
                  ),
              onPressed: () {
                // Action when button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResetPasswordPage()),
                );
              },
              child: Text(
                'تأكيد',
                style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.surfaceContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController
        .dispose(); // Dispose controller when not needed to prevent memory leaks
    super.dispose();
  }
}
