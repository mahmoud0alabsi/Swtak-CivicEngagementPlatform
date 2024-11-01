part of 'user_manager_bloc.dart';

abstract class UserManagerEvent {}

final class LoadUserData extends UserManagerEvent {}

final class AddUserVoteParliament extends UserManagerEvent {
  final String roundId;
  final String projectId;
  final String voteOption;

  AddUserVoteParliament(this.roundId, this.projectId, this.voteOption);
}

final class AddUserVoteMunicipality extends UserManagerEvent {
  final String projectId;
  final String voteOption;

  AddUserVoteMunicipality(this.projectId, this.voteOption);
}

final class AddCommentToMunicipalityProject extends UserManagerEvent {
  final String projectId;
  final String comment;

  AddCommentToMunicipalityProject(this.projectId, this.comment);
}
