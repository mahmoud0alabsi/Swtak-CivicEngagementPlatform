import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';
import 'package:citizens_voice_app/features/parliament/data/repositories/parliament_repository_impl.dart';

part 'ongoing_round_event.dart';
part 'ongoing_round_state.dart';

class OngoingRoundBloc extends Bloc<OngoingRoundEvent, OngoingRoundState> {
  final AuthRemoteDataSourceImpl _authRemoteDataSourceImpl =
      AuthRemoteDataSourceImpl();
  final ParliamentRepositoryImpl _parliamentRepositoryImpl =
      ParliamentRepositoryImpl();
  ParliamentRoundEntity _parliamentRoundEntity =
      ParliamentRoundEntity.emptyObj();
  late CustomUserEntity _user;

  OngoingRoundBloc() : super(OngoingRoundInitial()) {
    on<LoadOngoingRound>(_onLoadOngoingRound);
    add(LoadOngoingRound());
  }

  void _onLoadOngoingRound(
      LoadOngoingRound event, Emitter<OngoingRoundState> emit) async {
    emit(OngoingRoundLoading());
    try {
      _user = await _authRemoteDataSourceImpl.getCustomUser();

      _parliamentRoundEntity =
          await _parliamentRepositoryImpl.getOngoingRound();

      // assign userVote to each project in the round
      for (var project in _parliamentRoundEntity.projects) {
        if (_user.parliamentVotes[_parliamentRoundEntity.id] != null &&
            _user.parliamentVotes[_parliamentRoundEntity.id]![project.id] !=
                null) {
          project.userVote =
              _user.parliamentVotes[_parliamentRoundEntity.id]![project.id];
        }
      }

      emit(OngoingRoundLoaded());
    } catch (e) {
      emit(OngoingRoundError(e.toString()));
    }
  }

  ParliamentRoundEntity get ongoingParliamentRound => _parliamentRoundEntity;
}
