part of 'user_manager_bloc.dart';

abstract class UserManagerState {}

final class UserManagerInitial extends UserManagerState {}

final class UserManagerLoading extends UserManagerState {}

final class UserManagerLoaded extends UserManagerState {}

final class UserManagerError extends UserManagerState {
  final String message;

  UserManagerError(this.message);
}
