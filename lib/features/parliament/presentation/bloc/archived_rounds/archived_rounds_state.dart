part of 'archived_rounds_bloc.dart';

abstract class ArchivedRoundsState {}

final class ArchivedRoundsInitial extends ArchivedRoundsState {}

final class ArchivedRoundsLoading extends ArchivedRoundsState {}

final class ArchivedRoundsLoaded extends ArchivedRoundsState {}

final class ArchivedRoundsError extends ArchivedRoundsState {
  final String message;

  ArchivedRoundsError(this.message);
}
