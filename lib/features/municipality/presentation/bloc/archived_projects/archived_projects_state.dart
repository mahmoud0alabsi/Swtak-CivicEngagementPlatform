part of 'archived_projects_bloc.dart';

@immutable
sealed class ArchivedProjectsState {}

final class ArchivedProjectsInitial extends ArchivedProjectsState {}

final class ArchivedProjectsLoading extends ArchivedProjectsState {}

final class ArchivedProjectsLoaded extends ArchivedProjectsState {}

final class ArchivedProjectsError extends ArchivedProjectsState {
  final String errorMessage;

  ArchivedProjectsError(this.errorMessage);
}