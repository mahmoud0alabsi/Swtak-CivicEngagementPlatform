part of 'ongoing_projects_bloc.dart';

abstract class OngoingProjectsEvent {}

class VoteForProject extends OngoingProjectsEvent {
  final String projectId;
  final String voteOption;
  final BuildContext context;

  VoteForProject(this.projectId, this.voteOption, this.context);
}