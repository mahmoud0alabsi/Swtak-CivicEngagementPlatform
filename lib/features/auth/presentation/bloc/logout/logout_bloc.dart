import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/auth/data/repositories/auth_repository_impl.dart';
part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  AuthRepositoryImpl authRepository = AuthRepositoryImpl();
  LogoutBloc() : super(LogoutInitial()) {
    on<Logout>(_onLogout);
    on<OnLogoutSuccess>(_onLogoutSuccess);
  }

  Future<void> _onLogout(Logout event, Emitter<LogoutState> emit) async {
    emit(LoggingOut());
    try {
      await authRepository.logout();
      // TODO: Clear login credentials from cache
      add(OnLogoutSuccess());
    } catch (e) {
      emit(LogingOutFailed());
    }
  }

  void _onLogoutSuccess(OnLogoutSuccess event, Emitter<LogoutState> emit) {
    emit(LoggedOut());
  }
}
