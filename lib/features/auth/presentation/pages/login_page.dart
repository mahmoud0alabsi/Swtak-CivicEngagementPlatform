import 'package:citizens_voice_app/features/auth/const.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:citizens_voice_app/features/auth/presentation/pages/register_page.dart';
import 'package:citizens_voice_app/features/auth/presentation/pages/verification_page.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'frogot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nationalIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  String? _validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرقم الوطني مطلوب';
    }
    if (value.length != 10) {
      return 'يجب أن يتكون الرقم الوطني من 10 أرقام';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرقم السري مطلوب';
    } else if (value.length < 8) {
      return 'يجب أن يتكون الرقم السري من 8 أحرف على الأقل';
    }
    return null;
  }

  String avatarImage = 'assets/images/logo_transparent.png';

  @override
  void didChangeDependencies() {
    precacheImage(AssetImage(avatarImage), context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, otpState) {
          if (otpState is OtpSent) {
            // Navigate to OTP page
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => VerificationCodePage(
                  verificationId: otpState.verificationId,
                  from: 'login',
                  phoneNumber: otpState.phoneNumber,
                ),
              ),
            );
          } else if (otpState is OtpSentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(otpState.message),
                backgroundColor: Theme.of(context).colorScheme.error,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<OtpBloc, OtpState>(
          builder: (context, otpState) {
            if (otpState is OtpLoading) {
              const LoadingSpinner();
            }
            return BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                } else if (state is OnLoginVerifyNumberSuccess) {
                  context.read<OtpBloc>().add(
                        SendOtp(
                          data: {
                            kPhoneNumber: state.phoneNumber,
                          },
                        ),
                      );
                }
              },
              child: SafeArea(
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const LoadingSpinner();
                    }
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30), // Spacing
                            CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              radius: 85,
                              child: Image.asset(
                                avatarImage,
                                fit: BoxFit.contain,
                                width: 150,
                                height: 150,
                              ),
                            ),
                            const SizedBox(height: 30), // Spacing
                            Text(
                              'تسجيل الدخول',
                              style: TextStyle(
                                fontSize: 26,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8), // Spacing
                            Text(
                              'أهلا بك من جديد',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            const SizedBox(height: 40), // Spacing
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // National ID input field
                                  TextFormField(
                                    controller: _nationalIdController,
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    validator: _validateNationalId,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    buildCounter: (context,
                                            {required currentLength,
                                            required isFocused,
                                            required maxLength}) =>
                                        null,
                                    decoration: InputDecoration(
                                      labelText: 'الرقم الوطني',
                                      labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.75),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Color(0xFF9E9E9E),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.only(right: 10),
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  const SizedBox(height: 10),
                                  // Password input field with visibility toggle
                                  TextFormField(
                                    controller: _passwordController,
                                    keyboardType: TextInputType.text,
                                    obscureText: _obscurePassword,
                                    validator: _validatePassword,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      labelText: 'الرقم السري',
                                      labelStyle: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.75),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Color(0xFF9E9E9E)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          width: 2.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error,
                                          width: 2.0,
                                        ),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.only(right: 10),
                                      suffixIcon: IconButton(
                                        alignment: Alignment.centerLeft,
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: 20.0,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword; // Toggle visibility
                                          });
                                        },
                                      ),
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20), // Spacing
                            // Forgot password button
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 25),
                                  maximumSize: const Size(150, 25),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  // Action for forgot password
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'نسيت الرقم السري؟',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20), // Spacing

                            // Login button
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  BlocProvider.of<LoginBloc>(context).add(
                                    ValidateLoginCredentials(
                                      nationalId: _nationalIdController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer, // Background color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 6,
                                  shadowColor: Colors.black,
                                ),
                                child: Text(
                                  'الدخول',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Register button
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                                // Action for creating a new account
                              },
                              child: Text(
                                'ليس لديك حساب؟ إنشاء حساب جديد',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
