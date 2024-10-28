import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/auth/data/repositories/auth_repository_impl.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  AuthRepositoryImpl authRepository = AuthRepositoryImpl();
  Map<String, dynamic> data = {};
  int otpValidationTime = 15;
  int? resendOTPToken;
  Timer? _timer;
  int _otpResendTimer = 15;

  RegistrationBloc() : super(RegistrationInitial()) {
    resendOTPToken = 0;
    on<Register>(_onRegister);

    // on<SendOtp>(_onSendOtp);
    // on<OnOtpSent>(_onOtpSent);
    // on<OnSentOtpError>(_onSentOtpError);
    // on<VerifyOtp>(_onVerifyOtp);
    // on<OnOtpAuthError>(_onOtpAuthError);
    // on<OnOtpVerified>(_onOtpVerified);
    // on<ResentOtp>(_onResentOtp);
    // on<OtpResent>(_onOtpResent);
    // on<OtpResentError>(_onOtpResentError);
    // on<StartCountdown>(_onStartCountdown);
    // on<OnCountdownInProgress>(_onCountdownInProgress);
    // on<OnCountdownCompleted>(_onCountdownCompleted);
  }

  void _onRegister(Register event, Emitter<RegistrationState> emit) async {
    emit(RegistrationLoading());
    try {

    } catch (e) {

    }
  }

  // void _onSendOtp(SendOtp event, Emitter<RegistrationState> emit) {
  //   emit(RegistrationLoading());
  //   data = event.data;
  //   try {
  //     // Send OTP
  //     authRepository.sendOtp(
  //         phoneNumber: '+962${data[kPhoneNumber]}',
  //         onVerificationCompleted: (PhoneAuthCredential credential) {
  //           add(OnOtpVerified());
  //         },
  //         onVerificationFailed: (FirebaseAuthException e) {
  //           add(OnSentOtpError(message: e.message!));
  //         },
  //         onCodeSent: (String verificationId, int? resendToken) {
  //           resendOTPToken = resendToken;
  //           add(OnOtpSent(verificationId: verificationId, token: resendToken));
  //         },
  //         onCodeAutoRetrievalTimeout: (String verificationId) {});
  //     emit(OtpSent(verificationId: ''));
  //   } catch (e) {
  //     add(OnSentOtpError(message: 'Failed to verify phone number: $e'));
  //   }
  // }

  // void _onSentOtpError(OnSentOtpError event, Emitter<RegistrationState> emit) {
  //   emit(OtpSentError(message: event.message));
  // }

  // void _onOtpSent(OnOtpSent event, Emitter<RegistrationState> emit) {
  //   add(StartCountdown(time: otpValidationTime));
  //   emit(OtpSent(verificationId: event.verificationId));
  // }

  // Future<void> _onVerifyOtp(
  //     VerifyOtp event, Emitter<RegistrationState> emit) async {
  //   emit(OtpLoading());

  //   try {
  //     // Verify OTP
  //     final result = await authRepository.verifyOtp(
  //         verificationId: event.verificationId, smsCode: event.otp);
  //     if (result['status'] == 'success') {
  //       add(OnOtpVerified());
  //       data[kUid] = result['uid'];
  //       await authRepository.register(data: data);
  //     } else {
  //       add(OnOtpAuthError(message: result['message']));
  //     }
  //   } catch (e) {
  //     add(OnOtpAuthError(message: 'الرمز الذي أدخلته غير صحيح'));
  //   }
  // }

  // void _onOtpAuthError(OnOtpAuthError event, Emitter<RegistrationState> emit) {
  //   emit(OtpFaliure(message: event.message));
  // }

  // void _onOtpVerified(OnOtpVerified event, Emitter<RegistrationState> emit) {
  //   emit(OtpVerified());
  // }

  // void _onResentOtp(ResentOtp event, Emitter<RegistrationState> emit) {
  //   try {
  //     authRepository.resendOTP(
  //         phoneNumber: '+962${data[kPhoneNumber]}',
  //         resendToken: resendOTPToken!,
  //         onVerificationCompleted: (PhoneAuthCredential credential) {
  //           add(OnOtpVerified());
  //         },
  //         onVerificationFailed: (FirebaseAuthException e) {
  //           add(OnSentOtpError(message: e.message!));
  //         },
  //         onCodeSent: (String verificationId, int? resendToken) {
  //           resendOTPToken = resendToken;
  //           add(OtpResent(verificationId: verificationId, token: resendToken));
  //         },
  //         onCodeAutoRetrievalTimeout: (String verificationId) {});
  //   } catch (e) {
  //     emit(OTPResentError(
  //         message: 'لم يتم إعادة إرسال الرمز، يرجى المحاولة مرة أخرى'));
  //   }
  // }

  // void _onOtpResent(OtpResent event, Emitter<RegistrationState> emit) {
  //   add(StartCountdown(time: otpValidationTime));
  //   emit(OTPResent(verificationId: event.verificationId));
  // }

  // void _onOtpResentError(
  //     OtpResentError event, Emitter<RegistrationState> emit) {
  //   emit(OTPResentError(message: event.message));
  // }

  // void _onStartCountdown(
  //     StartCountdown event, Emitter<RegistrationState> emit) {
  //   _otpResendTimer = event.time;
  //   _timer?.cancel(); // Cancel any previous timer if active
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (_otpResendTimer > 0) {
  //       _otpResendTimer--;
  //       add(OnCountdownInProgress(time: _otpResendTimer));
  //     } else {
  //       timer.cancel();
  //       add(OnCountdownCompleted());
  //     }
  //   });
  // }

  // void _onCountdownInProgress(
  //     OnCountdownInProgress event, Emitter<RegistrationState> emit) {
  //   emit(CountdownInProgress(time: event.time));
  // }

  // void _onCountdownCompleted(
  //     OnCountdownCompleted event, Emitter<RegistrationState> emit) {
  //   emit(CountdownCompleted());
  // }
}
