import 'package:citizens_voice_app/features/auth/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IUserRemoteDataSource {
  Future<void> addUserVoteInParliament(
      String roundId, String projectId, String voteOption);

  Future<void> addUserVoteInMunicipality(String projectId, String voteOption);
  Future<void> addCommentToMunicipalityProject(
      String projectId, String comment);
}

class UserRemoteDataSourceImpl implements IUserRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addUserVoteInParliament(
      String roundId, String projectId, String voteOption) async {
    try {
      await _firestore
          .collection(usersCollection)
          .doc(_auth.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.exists) {
          await _firestore
              .collection(usersCollection)
              .doc(_auth.currentUser!.uid)
              .update({
            '$kParliamentVotes.$roundId.$projectId': voteOption,
          });
        }
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addUserVoteInMunicipality(String projectId, String voteOption) {
    try {
      return _firestore
          .collection(usersCollection)
          .doc(_auth.currentUser!.uid)
          .update({
        '$kMunicipalityVotes.$projectId': voteOption,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addCommentToMunicipalityProject(
      String projectId, String comment) {
    try {
      return _firestore
          .collection(usersCollection)
          .doc(_auth.currentUser!.uid)
          .update({
        '$kMunicipalityProjectsCommented.$projectId': comment,
      });
    } catch (e) {
      rethrow;
    }
  }
}
