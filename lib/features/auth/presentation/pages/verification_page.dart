import 'package:citizens_voice_app/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:citizens_voice_app/features/auth/presentation/pages/registration_success.dart';
import 'package:citizens_voice_app/features/home/presentation/pages/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerificationCodePage extends StatefulWidget {
  final String verificationId;
  final String from;
  final String phoneNumber;
  const VerificationCodePage(
      {super.key,
      required this.verificationId,
      required this.from,
      required this.phoneNumber});

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  bool hasShownSnackBar = false;

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Widget buildCodeNumberBox(int index) {
    return SizedBox(
      width: 45,
      height: 85,
      child: TextFormField(
        controller: controllers[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 1,
        cursorColor: Theme.of(context).colorScheme.secondary,
        cursorHeight: 30.0,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 2.0,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.red,
              width: 2.0,
            ),
          ),
          counterText: "",
          contentPadding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
            top: 10.0,
            bottom: 12.0,
          ),
          errorStyle: null,
        ),
        focusNode: focusNodes[index],
        textDirection: TextDirection.ltr, // Ensure input is left-to-right
        onChanged: (value) {
          if (value.length == 1 && index < 5) {
            focusNodes[index + 1].requestFocus();
          }
          // If the input is empty and the user deletes, focus on the previous field
          // if (value.isEmpty && index > 0) {
          //   focusNodes[index - 1].requestFocus();
          // }
          if (value.isNotEmpty && index == 5) {
            FocusScope.of(context).unfocus();
          }
        },
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.secondary,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '';
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpFaliure && !hasShownSnackBar) {
            hasShownSnackBar = true;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          } else if (state is OtpVerified) {
            widget.from == 'register'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationSuccess(),
                    ),
                  )
                : Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PagesWrapper(),
                    ),
                    (Route<dynamic> route) => false,
                  );
          }
        },
        child: BlocBuilder<OtpBloc, OtpState>(
          builder: (context, state) {
            if (state is OtpLoading || state is OtpVerified) {
              hasShownSnackBar = false;
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "رمز التحقق",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        widget.phoneNumber.isNotEmpty
                            ? 'من فضلك أدخل رمز التحقق المكون من 6 أرقام والذي تم إرساله إلى رقم هاتفك المنتهي ب XXXXXXX${widget.phoneNumber.substring(widget.phoneNumber.length - 3)}'
                            : 'من فضلك أدخل رمز التحقق المكون من 6 أرقام والذي تم إرساله إلى رقم هاتفك المنتهي ب XXXXXXX',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 30),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              6, (index) => buildCodeNumberBox(index)),
                        ),
                      ),
                      BlocBuilder<OtpBloc, OtpState>(
                        builder: (context, state) {
                          if (state is OTPResentError) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.message),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                              );
                            });
                          } else if (state is OTPResent) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('تم إعادة إرسال رمز التحقق'),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                ),
                              );
                            });
                          }
                          return InkWell(
                            onTap: context.read<OtpBloc>().isResentOtpEnabled()
                                ? () {
                                    BlocProvider.of<OtpBloc>(context).add(
                                      ResentOtp(),
                                    );
                                  }
                                : null,
                            child: Text(
                              !context.read<OtpBloc>().isResentOtpEnabled()
                                  ? '${context.read<OtpBloc>().getResendOtpTimer()} ثانية'
                                  : 'إعادة الإرسال',
                              style: TextStyle(
                                color: state is CountdownInProgress
                                    ? Colors.grey
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              String code = controllers
                                  .map((controller) => controller.text)
                                  .join();
                              // Implement code verification functionality here
                              BlocProvider.of<OtpBloc>(context).add(
                                widget.from == 'register'
                                    ? RegisterVerifyOtp(
                                        otp: code,
                                        verificationId: widget.verificationId,
                                      )
                                    : LoginVerifyOtp(
                                        otp: code,
                                        verificationId: widget.verificationId,
                                      ),
                              );
                              setState(() {});
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                      'من فضلك أدخل رمز التحقق المكون من 6 أرقام'),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.error,
                                ),
                              );
                            }
                          },
                          child: Text(
                            'تحقق',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ],
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
