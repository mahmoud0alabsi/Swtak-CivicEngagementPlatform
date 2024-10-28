part of 'otp_bloc.dart';

abstract class OtpState {}

final class OtpInitial extends OtpState {}

class OtpLoading extends OtpState {}

class OtpSent extends OtpState {
  final String verificationId;
  final String phoneNumber;

  OtpSent({required this.verificationId, required this.phoneNumber});
}

class OtpSentError extends OtpState {
  final String message;

  OtpSentError({required this.message});
}

class OtpVerified extends OtpState {}

class OtpFaliure extends OtpState {
  final String message;

  OtpFaliure({required this.message});
}

class OTPResent extends OtpState {
  final String verificationId;

  OTPResent({required this.verificationId});
}

class OTPResentError extends OtpState {
  final String message;

  OTPResentError({required this.message});
}

class CountdownInProgress extends OtpState {
  final int time;

  CountdownInProgress({required this.time});
}

class CountdownCompleted extends OtpState {}
