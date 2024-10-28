import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String, int?) onCodeSent,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String) onCodeAutoRetrievalTimeout,
  });

  Future<void> resendOTP({
    required String phoneNumber,
    required int resendToken,
    required Function(String, int?) onCodeSent,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(FirebaseAuthException) onVerificationFailed,
    required Function(String) onCodeAutoRetrievalTimeout,
  });

  Future<Map> verifyOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<CustomUserEntity> register({
    required Map<String, dynamic> data,
  });

  Future<CustomUserEntity> validateLoginCredentials({
    required Map<String, dynamic> data,
  });

  Future<void> logout();

  Stream<CustomUserEntity?> get firebaseAuthCustomUserStream;

  Future<CustomUserEntity> getCustomUser();
}
