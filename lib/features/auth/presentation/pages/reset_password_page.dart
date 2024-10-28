import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;

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
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button (optional)

              const SizedBox(height: 50), // Spacing

              // Title
              Text('رقم سري جديد',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.right),
              const SizedBox(height: 10), // Spacing

              // Instruction text
              Text(
                'قم بإدخال كلمة رمز سري مختلفة عن الرمز القديم.',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 60), // Spacing

              // New Password input field with visibility toggle
              TextField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "الرمز السري",
                  labelStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6)),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey), // Unfocused border color
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black), // Focused border color
                  ),
                  contentPadding: const EdgeInsets.only(right: 8),
                  suffixIcon: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                            !_obscurePassword; // Toggle visibility
                      });
                    },
                  ),
                ),
                textDirection: TextDirection.rtl, // Arabic text direction
              ),
              const SizedBox(height: 20), // Spacing

              // Confirm Password input field with visibility toggle
              TextField(
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: "تأكيد الرمز السري",
                  labelStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6)),
                  border: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey), // Unfocused border color
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black), // Focused border color
                  ),
                  contentPadding: const EdgeInsets.only(right: 8),
                  suffixIcon: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword =
                            !_obscurePassword; // Toggle visibility
                      });
                    },
                  ),
                ),
                textDirection: TextDirection.rtl, // Arabic text direction
              ),
              const SizedBox(height: 30), // Spacing

              // Update button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Action for updating password
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .primary, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'تحديث',
                    style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.surfaceContainer),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
