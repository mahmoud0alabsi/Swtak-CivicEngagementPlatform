import 'package:citizens_voice_app/core/errors/error_handler.dart';
import 'package:citizens_voice_app/core/network/network_handler.dart';
import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/business/repositories/auth_repository.dart';
import 'package:citizens_voice_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:citizens_voice_app/features/auth/data/models/custom_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDataSourceImpl remoteAuthDataSource =
      AuthRemoteDataSourceImpl();
  final InternetConnectionHandler internetConnectionHandler =
      InternetConnectionHandler();

  PhoneAuthCredential? phoneAuthCredential;

  // Singleton
  static final AuthRepositoryImpl _instance = AuthRepositoryImpl._internal();

  factory AuthRepositoryImpl() {
    return _instance;
  }

  AuthRepositoryImpl._internal();

  @override
  Stream<CustomUserEntity?> get firebaseAuthCustomUserStream {
    try {
      return remoteAuthDataSource.firebaseAuthUser;
    } catch (e, stackTrace) {
      ErrorHandler.crashlyticsLogError(
        e,
        stackTrace,
        reason: 'Error in firebaseAuthCustomUser method in AuthRepositoryImpl',
      );
      rethrow;
    }
  }

  @override
  Future<void> sendOtp(
      {required String phoneNumber,
      required Function(String, int?) onCodeSent,
      required Function(PhoneAuthCredential) onVerificationCompleted,
      required Function(FirebaseAuthException) onVerificationFailed,
      required Function(String) onCodeAutoRetrievalTimeout}) async {
    try {
      await remoteAuthDataSource.sendOtp(
        phoneNumber: phoneNumber,
        onCodeSent: onCodeSent,
        onVerificationCompleted: onVerificationCompleted,
        onVerificationFailed: onVerificationFailed,
        onCodeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      );
      return;
    } catch (e, stackTrace) {
      ErrorHandler.crashlyticsLogError(
        e,
        stackTrace,
        reason: 'Error in sendOtp method in AuthRepositoryImpl',
      );
    }
  }

  @override
  Future<void> resendOTP(
      {required String phoneNumber,
      required int resendToken,
      required Function(String, int?) onCodeSent,
      required Function(PhoneAuthCredential) onVerificationCompleted,
      required Function(FirebaseAuthException) onVerificationFailed,
      required Function(String) onCodeAutoRetrievalTimeout}) async {
    try {
      await remoteAuthDataSource.resendOTP(
        phoneNumber: phoneNumber,
        resendToken: resendToken,
        onCodeSent: onCodeSent,
        onVerificationCompleted: onVerificationCompleted,
        onVerificationFailed: onVerificationFailed,
        onCodeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      );
      return;
    } catch (e, stackTrace) {
      ErrorHandler.crashlyticsLogError(
        e,
        stackTrace,
        reason: 'Error in sendOtp method in AuthRepositoryImpl',
      );
    }
  }

  @override
  Future<Map> verifyOtp(
      {required String verificationId, required String smsCode}) async {
    try {
      return await remoteAuthDataSource.verifyOtp(
        verificationId: verificationId,
        smsCode: smsCode,
      );
    } catch (e, stackTrace) {
      ErrorHandler.crashlyticsLogError(
        e,
        stackTrace,
        reason: 'Error in verifyOtp method in AuthRepositoryImpl',
      );
      return {
        'status': 'error',
        'message': 'الرمز الذي أدخلته غير صحيح، يرجى المحاولة مرة أخرى',
      };
    }
  }

  @override
  Future<CustomUserModel> register({required Map<String, dynamic> data}) async {
    try {
      final CustomUserModel customUserModel =
          await remoteAuthDataSource.register(
        data: data,
      );
      return customUserModel;
    } catch (e, stackTrace) {
      ErrorHandler.crashlyticsLogError(
        e,
        stackTrace,
        reason: 'Error in register method in AuthRepositoryImpl',
      );
      rethrow;
    }
  }

  @override
  Future<CustomUserEntity> validateLoginCredentials(
      {required Map<String, dynamic> data}) {
    try {
      // 1- check if user exist in firestore
      // 2- if not exist, return error message
      // 3- if exist, verify phone number (send otp)
      // 4- if verified, return user data

      return remoteAuthDataSource.validateLoginCredentials(data: data);
    } catch (e, stackTrace) {
      ErrorHandler.crashlyticsLogError(
        e,
        stackTrace,
        reason: 'Error in login method in AuthRepositoryImpl',
      );
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      return await remoteAuthDataSource.logout();
    } catch (e, stackTrace) {
      ErrorHandler.crashlyticsLogError(
        e,
        stackTrace,
        reason: 'Error in logout method in AuthRepositoryImpl',
      );
      rethrow;
    }
  }

  @override
  Future<CustomUserEntity> getCustomUser() async {
    return await remoteAuthDataSource.getCustomUser();
  }
}
