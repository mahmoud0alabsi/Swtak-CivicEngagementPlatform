import 'package:citizens_voice_app/core/errors/error_handler.dart';
import 'package:citizens_voice_app/core/hashing/hashing_password.dart';
import 'package:citizens_voice_app/features/auth/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:citizens_voice_app/features/auth/data/models/custom_user_model.dart';

abstract class IAuthRemoteDataSource {
  Stream<CustomUserModel?> get firebaseAuthUser;
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

  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<CustomUserModel> register({
    required Map<String, dynamic> data,
  });
  Future<CustomUserModel> validateLoginCredentials({
    required Map<String, dynamic> data,
  });
  Future<void> logout();

  Future<CustomUserModel> getCustomUser();
}

class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String countryCode = '+962';

  // Singleton
  static final AuthRemoteDataSourceImpl _instance =
      AuthRemoteDataSourceImpl._internal();

  factory AuthRemoteDataSourceImpl() {
    return _instance;
  }

  AuthRemoteDataSourceImpl._internal();

  @override
  Stream<CustomUserModel?> get firebaseAuthUser {
    return _firebaseAuth.userChanges().map((firebaseUser) {
      if (firebaseUser == null || firebaseUser.uid.isEmpty) {
        return null;
      }
      return CustomUserModel.fromFirebaseAuthUser(firebaseUser);
    });
  }

  @override
  Future<void> sendOtp(
      {required String phoneNumber,
      required Function(String, int?) onCodeSent,
      required Function(PhoneAuthCredential) onVerificationCompleted,
      required Function(FirebaseAuthException) onVerificationFailed,
      required Function(String) onCodeAutoRetrievalTimeout}) async {
    try {
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          onVerificationCompleted(phoneAuthCredential);
        },
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      );
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in AuthRemoteDataSourceImpl.verifyPhoneNumber');
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
      _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 120),
        forceResendingToken: resendToken,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
          onVerificationCompleted(phoneAuthCredential);
        },
        verificationFailed: onVerificationFailed,
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: onCodeAutoRetrievalTimeout,
      );
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in AuthRemoteDataSourceImpl.verifyPhoneNumber');
    }
  }

  @override
  Future<Map> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential? userCredential =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      return {
        'status': 'success',
        'message': 'تم التحقق بنجاح',
        'uid': userCredential.user!.uid,
      };
      // return {
      //   'status': 'error',
      //   'message': 'الرمز الذي أدخلته غير صحيح، يرجى المحاولة مرة أخرى',
      // };
    } catch (e) {
      // ErrorHandler.crashlyticsLogError(e, StackTrace.current,
      //     reason: 'Error in AuthRemoteDataSourceImpl.verifyOtp');
      return {
        'status': 'error',
        'message': 'الرمز الذي أدخلته غير صحيح، يرجى المحاولة مرة أخرى',
      };
    }
  }

  // this will called after verify phone number
  // and will init user data in firestore (users collection)
  @override
  Future<CustomUserModel> register({required Map<String, dynamic> data}) async {
    try {
      CustomUserModel customUserModel = CustomUserModel.empty();

      String salt = HashingPassword.generateSalt();
      await _firestore.collection(usersCollection).doc(data[kUid]).set({
        kNationalId: data[kNationalId],
        kFullName: data[kFullName],
        kResidence: data[kResidence],
        kPhoneNumber: data[kPhoneNumber],
        kPasswordMap: {
          kHashedPassword: HashingPassword.hashPassword(data['password'], salt),
          kSalt: salt,
        },
        kParliamentVotes: {},
        kMunicipalityVotes: {},
      }).then((value) {
        data.addAll({
          kParliamentVotes: <String, dynamic>{},
          kMunicipalityVotes: <String, dynamic>{},
        });
        customUserModel = CustomUserModel.fromJson(json: data);
      });
      return customUserModel;
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in AuthRemoteDataSourceImpl.register');
      return CustomUserModel.empty();
    }
  }

  // Flow of login:
  // 1. Check if user exist by national id
  // 2. If user exist, get user data from firestore
  // 3. Verify password with hashed password and salt
  // 4. If password is correct, return user data
  // 5. If password is incorrect, return empty user data
  @override
  Future<CustomUserModel> validateLoginCredentials(
      {required Map<String, dynamic> data}) async {
    try {
      bool isUserExist = await isUserExistByNID(nationalId: data[kNationalId]);
      if (!isUserExist) {
        return CustomUserModel.empty();
      } else {
        final QuerySnapshot<Map<String, dynamic>> querySnapshot =
            await _firestore
                .collection(usersCollection)
                .where(kNationalId, isEqualTo: data[kNationalId])
                .get();
        final userData = querySnapshot.docs.first.data();
        userData[kUid] = querySnapshot.docs.first.id;
        if (!HashingPassword.verifyPassword(
            data['password'],
            userData[kPasswordMap][kHashedPassword],
            userData[kPasswordMap][kSalt])) {
          return CustomUserModel.empty();
        } else {
          return CustomUserModel(
            uid: userData[kUid],
            nationalId: userData[kNationalId],
            fullName: userData[kFullName],
            phoneNumber: userData[kPhoneNumber],
            residence: userData[kResidence],
            parliamentVotes: userData[kParliamentVotes] ?? {},
            municipalityVotes: userData[kMunicipalityVotes] ?? {},
          );
          // String verificationId = '';
          // _firebaseAuth.verifyPhoneNumber(
          //   phoneNumber: countryCode + userData[kPhoneNumber],
          //   timeout: const Duration(seconds: 120),
          //   verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
          //   verificationFailed: (FirebaseAuthException e) {},
          //   codeSent: (String verificationId, int? resendToken) {
          //     verificationId = verificationId;
          //   },
          //   codeAutoRetrievalTimeout: (String verificationId) {},
          // );
          // final PhoneAuthCredential phoneAuthCredential =
          //     PhoneAuthProvider.credential(
          //   verificationId: verificationId,
          //   smsCode: '555555',
          // );
          // UserCredential? userCredential =
          //     await _firebaseAuth.signInWithCredential(phoneAuthCredential!);

          // _firebaseAuth.signInWithPhoneNumber(
          //   '+962${userData[kPhoneNumber]}',
          // );
          // return CustomUserModel.fromJson(json: userData);
          // return CustomUserModel(
          //     uid: userData[kUid],
          //     nationalId: userData[kNationalId],
          //     fullName: userData[kFullName],
          //     phoneNumber: userData[kPhoneNumber]);
        }
      }
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in AuthRemoteDataSourceImpl.login');
      return CustomUserModel.empty();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      return;
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in AuthRemoteDataSourceImpl.logout');
    }
  }

  Future<bool> isUserExistByNID({required String nationalId}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(usersCollection)
          .where(kNationalId, isEqualTo: nationalId)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in AuthRemoteDataSourceImpl.checkUserExistByNID');
      return false;
    }
  }

  @override
  Future<CustomUserModel> getCustomUser() async {
    try {
      CustomUserModel authUser =
          CustomUserModel.fromFirebaseAuthUser(_firebaseAuth.currentUser!);
      final user =
          await _firestore.collection(usersCollection).doc(authUser.uid).get();

      var data = user.data()!;
      data[kUid] = user.id;
      return Future.value(CustomUserModel.fromJson(json: data));
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in AuthRemoteDataSourceImpl.getCustomUser');
      return Future.value(CustomUserModel.empty());
    }
  }
}
