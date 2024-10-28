// ignore_for_file: collection_methods_unrelated_type

import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/data/models/custom_user_model.dart';
import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';
import 'package:citizens_voice_app/features/parliament/const.dart';
import 'package:citizens_voice_app/features/parliament/data/repositories/parliament_repository_impl.dart';

part 'archived_rounds_event.dart';
part 'archived_rounds_state.dart';

class ArchivedRoundsBloc
    extends Bloc<ArchivedRoundsEvent, ArchivedRoundsState> {
  final ParliamentRepositoryImpl _parliamentRepositoryImpl =
      ParliamentRepositoryImpl();
  CustomUserEntity user = CustomUserModel.empty();
  List<ParliamentRoundEntity> _archivedRounds = [];

  // Singleton instance
  static ArchivedRoundsBloc? _instance;

  ArchivedRoundsBloc._internal({required this.user})
      : super(ArchivedRoundsInitial()) {
    on<LoadArchivedRound>(_onLoadArchivedRound);

    add(LoadArchivedRound());
  }

  factory ArchivedRoundsBloc({required CustomUserEntity user}) {
    // Factory constructor to return the same instance
    _instance ??= ArchivedRoundsBloc._internal(user: user);
    return _instance!;
  }

  // ArchivedRoundsBloc({
  //   required this.user,
  // }) : super(ArchivedRoundsInitial()) {
  //   on<LoadArchivedRound>(_onLoadArchivedRound);

  //   add(LoadArchivedRound());
  // }

  void _onLoadArchivedRound(
      LoadArchivedRound event, Emitter<ArchivedRoundsState> emit) async {
    emit(ArchivedRoundsLoading());
    try {
      _archivedRounds = await _parliamentRepositoryImpl.getArchivedRounds();
      _archivedRounds =
          checkUserVotingsInRounds(); // check if user voted in any of the archived rounds, if voted, update the project with the user's vote
      _archivedRounds.sort((a, b) => b.roundNumber.compareTo(a.roundNumber));
      emit(ArchivedRoundsLoaded());
    } catch (e) {
      emit(ArchivedRoundsError(e.toString()));
    }
  }

  List<ParliamentRoundEntity> checkUserVotingsInRounds() {
    List<ParliamentRoundEntity> updatedRounds = [];
    for (var round in _archivedRounds) {
      if (user.parliamentVotes.containsKey(round.roundNumber.toString())) {
        for (var project in round.projects) {
          if (user.parliamentVotes[round.roundNumber.toString()]
              .containsKey(project.projectNumber.toString())) {
            project.userVote =
                user.parliamentVotes[round.roundNumber.toString()]
                            [project.projectNumber.toString()] ==
                        kAgree
                    ? kAgreeAr
                    : kDisagreeAr;
          }
        }
      }
      updatedRounds.add(round);
    }
    return updatedRounds;
  }

  List<ParliamentRoundEntity> get archivedRounds => _archivedRounds;
}
