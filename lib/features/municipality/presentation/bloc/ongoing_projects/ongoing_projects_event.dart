part of 'ongoing_projects_bloc.dart';

@immutable
sealed class OngoingProjectsEvent {}

class LoadOngoingProjects extends OngoingProjectsEvent {}

class VoteForProject extends OngoingProjectsEvent {
  final String projectId;
  final String voteOption;
  final BuildContext context;

  VoteForProject(this.projectId, this.voteOption, this.context);
}

class AddCommentToProject extends OngoingProjectsEvent {
  final String projectId;
  final String comment;
  final BuildContext context;

  AddCommentToProject(this.projectId, this.comment, this.context);
}
