part of 'logout_bloc.dart';

abstract class LogoutEvent {}

class Logout extends LogoutEvent {}

class OnLogoutSuccess extends LogoutEvent {}
