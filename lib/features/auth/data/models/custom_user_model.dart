import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/const.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomUserModel extends CustomUserEntity {
  CustomUserModel({
    required super.uid,
    required super.nationalId,
    required super.fullName,
    required super.residence,
    required super.phoneNumber,
    required super.parliamentVotes,
    required super.municipalityVotes,
  });

  factory CustomUserModel.fromJson({required Map<String, dynamic> json}) {
    return CustomUserModel(
      uid: json[kUid],
      nationalId: json[kNationalId],
      fullName: json[kFullName],
      residence: json[kResidence],
      phoneNumber: json[kPhoneNumber],
      parliamentVotes: json[kParliamentVotes] ?? {},
      municipalityVotes: json[kMunicipalityVotes] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kUid: uid,
      kNationalId: nationalId,
      kFullName: fullName,
      kPhoneNumber: phoneNumber,
    };
  }

  factory CustomUserModel.fromFirebaseAuthUser(
    User firebaseUser,
  ) {
    return CustomUserModel(
      uid: firebaseUser.uid,
      phoneNumber: firebaseUser.phoneNumber ?? '',
      nationalId: '',
      fullName: '',
      residence: '',
      parliamentVotes: {},
      municipalityVotes: {},
    );
  }

  static CustomUserModel empty() {
    return CustomUserModel(
      uid: '',
      phoneNumber: '',
      nationalId: '',
      fullName: '',
      residence: '',
      parliamentVotes: {},
      municipalityVotes: {},
    );
  }
}
