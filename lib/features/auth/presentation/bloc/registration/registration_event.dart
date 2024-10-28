part of 'registration_bloc.dart';

abstract class RegistrationEvent {}

class Register extends RegistrationEvent {
  final Map<String, dynamic> data;

  Register({required this.data});
}

class SendOtp extends RegistrationEvent {
  final Map<String, dynamic> data;

  SendOtp({required this.data});
}

class OnOtpSent extends RegistrationEvent {
  final String verificationId;
  final int? token;

  OnOtpSent({required this.verificationId, required this.token});
}

class OnSentOtpError extends RegistrationEvent {
  final String message;

  OnSentOtpError({required this.message});
}

class VerifyOtp extends RegistrationEvent {
  final String otp;
  final String verificationId;

  VerifyOtp({required this.otp, required this.verificationId});
}

class OnOtpAuthError extends RegistrationEvent {
  final String message;

  OnOtpAuthError({required this.message});
}

class OnOtpVerified extends RegistrationEvent {
  // final AuthCredential credential;
  // final UserCredential? userCredential;

  // OnOtpVerified({required this.credential, this.userCredential});
}

class ResentOtp extends RegistrationEvent {}

class OtpResentError extends RegistrationEvent {
  final String message;

  OtpResentError({required this.message});
}

class OtpResent extends RegistrationEvent {
  final String verificationId;
  final int? token;


  OtpResent({required this.verificationId, required this.token});
}

class StartCountdown extends RegistrationEvent {
  final int time;
  StartCountdown({required this.time});
}

class OnCountdownInProgress extends RegistrationEvent {
  final int time;
  OnCountdownInProgress({required this.time});
}

class OnCountdownCompleted extends RegistrationEvent {}
