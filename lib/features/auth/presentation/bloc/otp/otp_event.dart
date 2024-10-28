part of 'otp_bloc.dart';

abstract class OtpEvent {}


class SendOtp extends OtpEvent {
  final Map<String, dynamic> data;

  SendOtp({required this.data});
}

class OnOtpSent extends OtpEvent {
  final String verificationId;
  final int? token;

  OnOtpSent({required this.verificationId, required this.token});
}

class OnSentOtpError extends OtpEvent {
  final String message;

  OnSentOtpError({required this.message});
}

class RegisterVerifyOtp extends OtpEvent {
  final String otp;
  final String verificationId;

  RegisterVerifyOtp({required this.otp, required this.verificationId});
}

class LoginVerifyOtp extends OtpEvent {
  final String otp;
  final String verificationId;

  LoginVerifyOtp({required this.otp, required this.verificationId});
}


class OnOtpAuthError extends OtpEvent {
  final String message;

  OnOtpAuthError({required this.message});
}

class OnOtpVerified extends OtpEvent {
  // final AuthCredential credential;
  // final UserCredential? userCredential;

  // OnOtpVerified({required this.credential, this.userCredential});
}

class ResentOtp extends OtpEvent {}

class OtpResentError extends OtpEvent {
  final String message;

  OtpResentError({required this.message});
}

class OtpResent extends OtpEvent {
  final String verificationId;
  final int? token;


  OtpResent({required this.verificationId, required this.token});
}

class StartCountdown extends OtpEvent {
  final int time;
  StartCountdown({required this.time});
}

class OnCountdownInProgress extends OtpEvent {
  final int time;
  OnCountdownInProgress({required this.time});
}

class OnCountdownCompleted extends OtpEvent {}
