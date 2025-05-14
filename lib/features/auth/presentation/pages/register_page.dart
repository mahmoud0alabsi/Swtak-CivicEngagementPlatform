import 'package:citizens_voice_app/features/auth/const.dart';
import 'package:citizens_voice_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/suggestions_metadata.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_page.dart';
import 'verification_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nationalIdController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? selectedResidence;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String? selectedGovernorate;
  String? selectedCity;
  String? selectedArea;

  String? _validateNationalId(String? value) {
    if (value == null || value.isEmpty) {
      return 'الرقم الوطني مطلوب';
    } else if (value.length != 10) {
      return 'يجب أن يتكون الرقم الوطني من 10 أرقام';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'الإسم الرباعي مطلوب';
    }
    return null;
  }

  String? _validateResidence(String? value) {
    if (value == null) {
      return 'مكان الإقامة مطلوب';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'رقم الهاتف مطلوب';
    } else if (!RegExp(r'^7').hasMatch(value)) {
      return 'رقم الهاتف غير صحيح، يجب أن يبدأ بـ 7';
    } else if (!RegExp(r'^7[789]').hasMatch(value)) {
      return 'رقم الهاتف غير صحيح، يجب أن يبدأ بـ 77 أو 78 أو 79';
    } else if (value.length != 9) {
      return 'يجب أن يتكون رقم الهاتف من 9 أرقام';
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

  String? _validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'تأكيد الرقم السري غير متطابق';
    } else if (value == null || value.isEmpty) {
      return 'تأكيد الرقم السري مطلوب';
    } else if (value.length < 8) {
      return 'يجب أن يتكون تأكيد الرقم السري من 8 أحرف على الأقل';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpSent) {
            // Navigate to OTP page
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => VerificationCodePage(
                  verificationId: state.verificationId,
                  from: 'register',
                  phoneNumber: state.phoneNumber,
                ),
              ),
            );
          } else if (state is OtpSentError) {
            // Get.snackbar(
            //   'Error',
            //   state.message,
            //   colorText: Theme.of(context).colorScheme.secondary,
            //   backgroundColor: Theme.of(context).colorScheme.error,
            //   icon: Icon(Icons.error,
            //       color: Theme.of(context).colorScheme.secondary),
            //   margin: const EdgeInsets.all(10.0),
            // );
            // Display snackbar with error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        child: BlocBuilder<OtpBloc, OtpState>(
          builder: (context, state) {
            if (state is OtpLoading) {
              return const LoadingSpinner();
            }
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'مستخدم جديد',
                          style: TextStyle(
                            fontSize: 26,
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'أنشئ حساب جديد لتتمكن من تصفح التطبيق',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'الرجاء إدخال المعلومات التالية مطابقة لهوية الشخصية',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(height: 30),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // National ID input field
                              TextFormField(
                                controller: nationalIdController,
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
                                        color: Color(0xFF9E9E9E)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(right: 10),
                                ),
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Name
                              TextFormField(
                                controller: nameController,
                                validator: _validateName,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: 'الإسم الرباعي',
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
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(right: 10),
                                ),
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Place of Residence Dropdown field (Dropdown)
                              DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'المحافظة مطلوبة';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: 'المحافظة',
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
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(right: 10),
                                ),
                                items: governorates.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value,
                                        textDirection: TextDirection.rtl),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedResidence = newValue;
                                    selectedGovernorate = newValue;
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                isExpanded:
                                    true, // Make the dropdown span the full width
                                alignment: Alignment
                                    .centerRight, // Align dropdown content to the right
                              ),
                              const SizedBox(height: 15),
                              DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'المنطقة مطلوبة';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: 'المنطقة',
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
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(right: 10),
                                ),
                                items: municipalities[selectedGovernorate] !=
                                        null
                                    ? municipalities[selectedGovernorate]!
                                        .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              textDirection: TextDirection.rtl),
                                        );
                                      }).toList()
                                    : [],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedResidence = newValue;
                                    selectedCity = newValue;
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                isExpanded:
                                    true, // Make the dropdown span the full width
                                alignment: Alignment
                                    .centerRight, // Align dropdown content to the right
                              ),
                              const SizedBox(height: 15),
                              DropdownButtonFormField<String>(
                                validator: (value) {
                                  if (value == null) {
                                    return 'البلدية مطلوبة';
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: 'البلدية',
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
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(right: 10),
                                ),
                                items: areas[selectedCity] != null
                                    ? areas[selectedCity]!.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              textDirection: TextDirection.rtl),
                                        );
                                      }).toList()
                                    : [],
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedResidence = newValue;
                                    selectedArea = newValue;
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                isExpanded:
                                    true, // Make the dropdown span the full width
                                alignment: Alignment
                                    .centerRight, // Align dropdown content to the right
                              ),
                              const SizedBox(height: 15),
                              // Phone number input field
                              TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: _validatePhone,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                maxLength: 9,
                                buildCounter: (context,
                                        {required currentLength,
                                        required isFocused,
                                        required maxLength}) =>
                                    null,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  suffix: const Text(
                                    '+962 ',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  labelText: "رقم الهاتف",
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
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      right: 10, left: 10),
                                ),
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Password input field with visibility toggle (icon on the left)
                              TextFormField(
                                controller: passwordController,
                                validator: _validatePassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                obscureText: _obscurePassword,
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
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
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
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Confirm Password input field with visibility toggle (icon on the left)
                              TextFormField(
                                controller: confirmPasswordController,
                                validator: _validateConfirmPassword,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.text,
                                obscureText: _obscureConfirmPassword,
                                decoration: InputDecoration(
                                  labelText: "تأكيد الرقم السري",
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
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      width: 2.0,
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.only(right: 10),
                                  suffixIcon: IconButton(
                                    alignment: Alignment.centerLeft,
                                    icon: Icon(
                                      _obscureConfirmPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                  ),
                                ),
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Register button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              Map<String, dynamic> data = {
                                kNationalId: nationalIdController.text,
                                kFullName: nameController.text,
                                kResidence: selectedResidence,
                                kPhoneNumber: phoneController.text,
                                'password': passwordController.text,
                              };

                              bool isUserExist =
                                  await AuthRemoteDataSourceImpl()
                                      .isUserExistByNID(
                                          nationalId: data[kNationalId]);
                              if (isUserExist) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                        'هذا الرقم الوطني مسجل مسبقاً'),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error,
                                    duration: const Duration(seconds: 3),
                                  ),
                                );
                              } else {
                                BlocProvider.of<OtpBloc>(context)
                                    .add(SendOtp(data: data));
                              }
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
                              'إنشاء حساب',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainer),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Login button
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                            // Action for creating a new account
                          },
                          child: Text(
                            'لديك حساب؟ تسجيل الدخول',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                              overflow: TextOverflow.ellipsis,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
