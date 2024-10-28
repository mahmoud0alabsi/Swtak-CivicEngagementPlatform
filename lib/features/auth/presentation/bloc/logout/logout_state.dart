part of 'logout_bloc.dart';

abstract class LogoutState {}

final class LogoutInitial extends LogoutState {}

final class LoggingOut extends LogoutState {}

final class LoggedOut extends LogoutState {}

final class LogingOutFailed extends LogoutState {}