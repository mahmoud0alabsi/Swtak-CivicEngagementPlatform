import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/data/models/custom_user_model.dart';
import 'package:citizens_voice_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:citizens_voice_app/features/auth/data/repositories/user_repository_impl.dart';

part 'user_manager_event.dart';
part 'user_manager_state.dart';

class UserManagerBloc extends Bloc<UserManagerEvent, UserManagerState> {
  final AuthRepositoryImpl _authRepositoryImpl = AuthRepositoryImpl();
  final UserRepositoryImpl _userRepositoryImpl = UserRepositoryImpl();
  CustomUserEntity _user = CustomUserModel.empty();
  UserManagerBloc() : super(UserManagerInitial()) {
    on<LoadUserData>(_onLoadUserData);
    on<AddUserVoteParliament>(_onAddUserVotingParliament);
    on<AddUserVoteMunicipality>(_onAddUserVotingMunicipality);
    add(LoadUserData());
  }

  void _onLoadUserData(
      LoadUserData event, Emitter<UserManagerState> emit) async {
    emit(UserManagerLoading());
    try {
      _user = await _authRepositoryImpl.getCustomUser();
      emit(UserManagerLoaded());
    } catch (e) {
      emit(UserManagerError(e.toString()));
    }
  }

  void _onAddUserVotingParliament(
      AddUserVoteParliament event, Emitter<UserManagerState> emit) async {
    emit(UserManagerLoading());
    try {
      await _userRepositoryImpl.addUserVoteInParliament(
          event.roundId, event.projectId, event.voteOption);
      _user.parliamentVotes[event.roundId][event.projectId] = event.voteOption;

      emit(UserManagerLoaded());
    } catch (e) {
      emit(UserManagerError('حدث خطأ أثناء التصويت، يرجى المحاولة مرة أخرى'));
      rethrow;
    }
  }

  void _onAddUserVotingMunicipality(
      AddUserVoteMunicipality event, Emitter<UserManagerState> emit) async {
    emit(UserManagerLoading());
    try {
      await _userRepositoryImpl.addUserVoteInMunicipality(
          event.projectId, event.voteOption);
      _user.municipalityVotes[event.projectId] = event.voteOption;

      emit(UserManagerLoaded());
    } catch (e) {
      emit(UserManagerError('حدث خطأ أثناء التصويت، يرجى المحاولة مرة أخرى'));
      rethrow;
    }
  }

  CustomUserEntity get user => _user;
}
