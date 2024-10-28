part of 'ongoing_projects_bloc.dart';

abstract class OngoingProjectsState {}

final class OngoingProjectsInitial extends OngoingProjectsState {}

final class VoteOnProjectLoading extends OngoingProjectsState {}

final class VoteOnProjectDone extends OngoingProjectsState {
  final String message;

  VoteOnProjectDone(this.message);
}

final class OngoingProjectsError extends OngoingProjectsState {
  final String errorMessage;

  OngoingProjectsError(this.errorMessage);
}
