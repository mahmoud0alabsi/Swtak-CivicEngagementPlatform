part of 'archived_projects_bloc.dart';

@immutable
sealed class ArchivedProjectsEvent {}

class LoadArchivedProjects extends ArchivedProjectsEvent {}