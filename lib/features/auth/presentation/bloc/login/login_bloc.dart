import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/const.dart';
import 'package:citizens_voice_app/features/auth/data/repositories/auth_repository_impl.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthRepositoryImpl authRepository = AuthRepositoryImpl();
  LoginBloc() : super(LoginInitial()) {
    on<ValidateLoginCredentials>(_onValidateLoginCredentials);
    on<LoginVerifyNumber>(_onLoginVerifyNumber);
    on<OnLoginError>(_onLoginError);
    on<OnLoginSuccess>(_onLoginSuccess);
    on<StoreLoginCredentials>(_onStoreLoginCredentials);
    on<AutoLogin>(_onAutoLogin);
  }

  void _onValidateLoginCredentials(
      ValidateLoginCredentials event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      CustomUserEntity user = await authRepository.validateLoginCredentials(
        data: {
          kNationalId: event.nationalId,
          'password': event.password,
        },
      );

      if (user.uid != '') {
        add(LoginVerifyNumber(
          phoneNumber: user.phoneNumber,
        ));
      } else {
        add(OnLoginError(
            message: 'الرقم الوطني أو كلمة المرور غير صحيحة، يرجى المحاولة مرة أخرى'));
      }
    } catch (e) {
      emit(LoginFailure(message: e.toString()));
    }
  }

  void _onLoginVerifyNumber(LoginVerifyNumber event, Emitter<LoginState> emit) {
    emit(OnLoginVerifyNumberSuccess(
      phoneNumber: event.phoneNumber,
    ));
  }

  void _onLoginError(OnLoginError event, Emitter<LoginState> emit) {
    emit(LoginFailure(message: event.message));
  }

  void _onLoginSuccess(OnLoginSuccess event, Emitter<LoginState> emit) {
    emit(LoginSuccess(message: event.message));
  }

  void _onStoreLoginCredentials(
      StoreLoginCredentials event, Emitter<LoginState> emit) {
    // emit(LoginSuccess(message: 'Credentials stored successfully'));
    // TODO: Implement storing credentials
  }

  void _onAutoLogin(AutoLogin event, Emitter<LoginState> emit) {
    // TODO: Implement auto login
  }
}
