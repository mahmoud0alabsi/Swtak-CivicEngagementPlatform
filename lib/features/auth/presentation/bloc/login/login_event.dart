part of 'login_bloc.dart';

abstract class LoginEvent {}

class ValidateLoginCredentials extends LoginEvent {
  final String nationalId;
  final String password;

  ValidateLoginCredentials({required this.nationalId, required this.password});
}

class OnLoginError extends LoginEvent {
  final String message;

  OnLoginError({required this.message});
}

class LoginVerifyNumber extends LoginEvent {
  final String phoneNumber;

  LoginVerifyNumber({required this.phoneNumber});
}

class OnLoginSuccess extends LoginEvent {
  final String message;

  OnLoginSuccess({required this.message});
}

class StoreLoginCredentials extends LoginEvent {
  final String nationalId;
  final String password;

  StoreLoginCredentials({required this.nationalId, required this.password});
}

class AutoLogin extends LoginEvent {}
