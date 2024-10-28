part of 'ongoing_projects_bloc.dart';

@immutable
sealed class OngoingProjectsState {}

final class OngoingProjectsInitial extends OngoingProjectsState {}

final class OngoingProjectsLoading extends OngoingProjectsState {}

final class OngoingProjectsLoaded extends OngoingProjectsState {}

final class OngoingProjectsError extends OngoingProjectsState {
  final String errorMessage;

  OngoingProjectsError(this.errorMessage);
}

final class VoteOnProjectLoading extends OngoingProjectsState {}

final class VoteOnProjectDone extends OngoingProjectsState {
  final String message;

  VoteOnProjectDone(this.message);
}