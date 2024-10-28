part of 'registration_bloc.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}

class RegistrationSuccess extends RegistrationState {
  final String message;

  RegistrationSuccess({required this.message});
}

class RegistrationFailure extends RegistrationState {
  final String message;

  RegistrationFailure({required this.message});
}

class OtpLoading extends RegistrationState {}

class OtpSent extends RegistrationState {
  final String verificationId;

  OtpSent({required this.verificationId});
}

class OtpSentError extends RegistrationState {
  final String message;

  OtpSentError({required this.message});
}

class OtpVerified extends RegistrationState {}

class OtpFaliure extends RegistrationState {
  final String message;

  OtpFaliure({required this.message});
}

class OTPResent extends RegistrationState {
  final String verificationId;

  OTPResent({required this.verificationId});
}

class OTPResentError extends RegistrationState {
  final String message;

  OTPResentError({required this.message});
}

class CountdownInProgress extends RegistrationState {
  final int time;

  CountdownInProgress({required this.time});
}

class CountdownCompleted extends RegistrationState {}
