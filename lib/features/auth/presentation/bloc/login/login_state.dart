part of 'login_bloc.dart';

abstract class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class OnLoginVerifyNumberSuccess extends LoginState {
  final String phoneNumber;

  OnLoginVerifyNumberSuccess({required this.phoneNumber});
}

final class LoginSuccess extends LoginState {
  final String message;

  LoginSuccess({required this.message});
}

final class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}
