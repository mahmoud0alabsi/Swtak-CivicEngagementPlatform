import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';
import 'package:citizens_voice_app/features/parliament/const.dart';
import 'package:citizens_voice_app/features/parliament/data/repositories/parliament_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ongoing_projects_event.dart';
part 'ongoing_projects_state.dart';

class OngoingProjectsBloc
    extends Bloc<OngoingProjectsEvent, OngoingProjectsState> {
  final ParliamentRepositoryImpl _parliamentRepositoryImpl =
      ParliamentRepositoryImpl();
  late ParliamentRoundEntity _parliamentRoundEntity;
  OngoingProjectsBloc({
    required ParliamentRoundEntity parliamentRoundEntity,
  }) : super(OngoingProjectsInitial()) {
    _parliamentRoundEntity = parliamentRoundEntity;

    on<VoteForProject>(_onVoteForProject);
  }

  void _onVoteForProject(
      VoteForProject event, Emitter<OngoingProjectsState> emit) async {
    emit(VoteOnProjectLoading());
    try {
      String userVote = event.voteOption == kAgreeAr ? kAgree : kDisagree;

      // store vote in user's votes (users collection)
      event.context.read<UserManagerBloc>().add(AddUserVoteParliament(
            _parliamentRoundEntity.id,
            event.projectId,
            userVote,
          ));

      // store vote on selected project in the round
      for (var project in _parliamentRoundEntity.projects) {
        if (project.id == event.projectId) {
          project.userVote = userVote;
          project.voting[userVote] = project.voting[userVote]! + 1;
          break;
        }
      }

      await _parliamentRepositoryImpl.voteForProject(
          _parliamentRoundEntity.id, event.projectId, userVote);

      emit(VoteOnProjectDone('تم التصويت بنجاح، شكراً لك على مشاركتك'));
    } catch (e) {
      emit(OngoingProjectsError(
          'حدث خطأ أثناء التصويت، يرجى المحاولة مرة أخرى'));
    }
  }

  ParliamentRoundEntity get ongoingParliamentRound => _parliamentRoundEntity;
}
