import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/auth/const.dart';
import 'package:citizens_voice_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:citizens_voice_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  AuthRepositoryImpl authRepository = AuthRepositoryImpl();
  String countryCode = '+962';
  Map<String, dynamic> data = {};
  int otpValidationTime = 120;
  int? resendOTPToken;
  Timer? _timer;
  int _otpResendTimer = 120;

  OtpBloc() : super(OtpInitial()) {
    resendOTPToken = 0;
    on<SendOtp>(_onSendOtp);
    on<OnOtpSent>(_onOtpSent);
    on<OnSentOtpError>(_onSentOtpError);
    on<RegisterVerifyOtp>(_onRegisterVerifyOtp);
    on<LoginVerifyOtp>(_onLoginVerifyOtp);
    on<OnOtpAuthError>(_onOtpAuthError);
    on<OnOtpVerified>(_onOtpVerified);
    on<ResentOtp>(_onResentOtp);
    on<OtpResent>(_onOtpResent);
    on<OtpResentError>(_onOtpResentError);
    on<StartCountdown>(_onStartCountdown);
    on<OnCountdownInProgress>(_onCountdownInProgress);
    on<OnCountdownCompleted>(_onCountdownCompleted);
  }

  void _onSendOtp(SendOtp event, Emitter<OtpState> emit) {
    emit(OtpLoading());
    data = event.data;
    try {
      // Send OTP
      authRepository.sendOtp(
          phoneNumber: countryCode + data[kPhoneNumber],
          onVerificationCompleted: (PhoneAuthCredential credential) {
            add(OnOtpVerified());
          },
          onVerificationFailed: (FirebaseAuthException e) {
            add(OnSentOtpError(
                message: e.message!.contains('BILLING_NOT_ENABLED')
                    ? 'الرجاء التأكد من تفعيل خدمة الرسائل النصية على هاتفك'
                    : e.message!));
          },
          onCodeSent: (String verificationId, int? resendToken) {
            resendOTPToken = resendToken;
            add(OnOtpSent(verificationId: verificationId, token: resendToken));
          },
          onCodeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      add(OnSentOtpError(
          message: 'لم يتم إرسال الرمز، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onSentOtpError(OnSentOtpError event, Emitter<OtpState> emit) {
    emit(OtpSentError(message: event.message));
  }

  void _onOtpSent(OnOtpSent event, Emitter<OtpState> emit) {
    add(StartCountdown(time: otpValidationTime));
    emit(OtpSent(
        verificationId: event.verificationId, phoneNumber: data[kPhoneNumber]));
  }

  Future<void> _onRegisterVerifyOtp(
      RegisterVerifyOtp event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
      // check if the user is already registered
      bool isUserExist = await AuthRemoteDataSourceImpl()
          .isUserExistByNID(nationalId: data[kNationalId]);
      if (isUserExist) {
        add(OnOtpAuthError(message: 'هذا الرقم الوطني مسجل مسبقا'));
      } else {
        // Verify OTP
        final result = await authRepository.verifyOtp(
            verificationId: event.verificationId, smsCode: event.otp);
        if (result['status'] == 'success') {
          add(OnOtpVerified());
          data[kUid] = result['uid'];
          await authRepository.register(data: data);
        } else {
          add(OnOtpAuthError(message: result['message']));
        }
      }
    } catch (e) {
      add(OnOtpAuthError(message: 'الرمز الذي أدخلته غير صحيح'));
    }
  }

  Future<void> _onLoginVerifyOtp(
      LoginVerifyOtp event, Emitter<OtpState> emit) async {
    emit(OtpLoading());

    try {
      // Verify OTP
      final result = await authRepository.verifyOtp(
          verificationId: event.verificationId, smsCode: event.otp);
      if (result['status'] == 'success') {
        add(OnOtpVerified());
      } else {
        add(OnOtpAuthError(message: result['message']));
      }
    } catch (e) {
      add(OnOtpAuthError(message: 'الرمز الذي أدخلته غير صحيح'));
    }
  }

  void _onOtpAuthError(OnOtpAuthError event, Emitter<OtpState> emit) {
    emit(OtpFaliure(message: event.message));
  }

  void _onOtpVerified(OnOtpVerified event, Emitter<OtpState> emit) {
    emit(OtpVerified());
  }

  void _onResentOtp(ResentOtp event, Emitter<OtpState> emit) {
    try {
      authRepository.resendOTP(
          phoneNumber: countryCode + data[kPhoneNumber],
          resendToken: resendOTPToken!,
          onVerificationCompleted: (PhoneAuthCredential credential) {
            add(OnOtpVerified());
          },
          onVerificationFailed: (FirebaseAuthException e) {
            add(OnSentOtpError(message: e.message!));
          },
          onCodeSent: (String verificationId, int? resendToken) {
            resendOTPToken = resendToken;
            add(OtpResent(verificationId: verificationId, token: resendToken));
          },
          onCodeAutoRetrievalTimeout: (String verificationId) {});
    } catch (e) {
      emit(OTPResentError(
          message: 'لم يتم إعادة إرسال الرمز، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onOtpResent(OtpResent event, Emitter<OtpState> emit) {
    add(StartCountdown(time: otpValidationTime));
    emit(OTPResent(verificationId: event.verificationId));
  }

  void _onOtpResentError(OtpResentError event, Emitter<OtpState> emit) {
    emit(OTPResentError(message: event.message));
  }

  void _onStartCountdown(StartCountdown event, Emitter<OtpState> emit) {
    _otpResendTimer = event.time;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_otpResendTimer > 0) {
        _otpResendTimer--;
        add(OnCountdownInProgress(time: _otpResendTimer));
      } else {
        timer.cancel();
        add(OnCountdownCompleted());
      }
    });
  }

  void _onCountdownInProgress(
      OnCountdownInProgress event, Emitter<OtpState> emit) {
    emit(CountdownInProgress(time: event.time));
  }

  void _onCountdownCompleted(
      OnCountdownCompleted event, Emitter<OtpState> emit) {
    emit(CountdownCompleted());
  }

  bool isResentOtpEnabled() {
    return _otpResendTimer == 0;
  }

  int getResendOtpTimer() {
    return _otpResendTimer;
  }
}
