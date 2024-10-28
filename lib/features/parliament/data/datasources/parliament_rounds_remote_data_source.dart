import 'package:citizens_voice_app/core/errors/error_handler.dart';
import 'package:citizens_voice_app/features/parliament/const.dart';
import 'package:citizens_voice_app/features/parliament/data/models/parliament_project_model.dart';
import 'package:citizens_voice_app/features/parliament/data/models/parliament_round_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IParliamentRoundsDataSource {
  Future<ParliamentRoundModel> getOngoingRound();
  Future<List<ParliamentRoundModel>> getArchivedRounds();
  Future<ParliamentRoundModel> getOngoingRoundInfo();
  Future<List<ParliamentProjectModel>> getRoundProjectsByRoundId(
      String roundId);

  Future<Map<String, dynamic>> voteForProject(
      String roundId, String projectId, String vote);
}

class ParliamentRoundsDataSourceImpl implements IParliamentRoundsDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Singleton
  static final ParliamentRoundsDataSourceImpl _instance =
      ParliamentRoundsDataSourceImpl._internal();
  factory ParliamentRoundsDataSourceImpl() {
    return _instance;
  }
  ParliamentRoundsDataSourceImpl._internal();

  @override
  Future<ParliamentRoundModel> getOngoingRound() async {
    try {
      // await _firestore
      //     .collection(parliamentRoundsCollection)
      //     .doc('HZnfVjrFZ3SpHrLsbA11')
      //     .collection(projectsSubCollection)
      //     .add({
      //   kTitle: 'مشروع الباص السريع',
      //   kDetails:
      //       'مشروع دعم الطالب مشروع دعم الطالب مشروع دعم الطالب مشروع دعم الطالب مشروع دعم الطالب مشروع دعم الطالب.',
      //   kProjectNumber: 2,
      //   kType: 'نقل',
      //   kTags: [
      //     'نقل',
      //   ],
      //   kResponsibleInstitution: 'وزارة التربية والتعليم',
      //   kVoting: {
      //     kAgree: 1456,
      //     kDisagree: 123,
      //   },
      // });

      // await _firestore
      //     .collection(parliamentRoundsCollection)
      //     .doc('HZnfVjrFZ3SpHrLsbA11')
      //     .collection(projectsSubCollection)
      //     .add({
      //   kTitle: 'مشروع التجارة الإلكترونية',
      //   kDetails:
      //       'مشروع دعم الطالب مشروع دعم الطالب مشروع دعم الطالب مشروع دعم الطالب مشروع دعم الطالب مشروع دعم الطالب.',
      //   kProjectNumber: 3,
      //   kType: 'تجارة',
      //   kTags: [
      //     'تجارة',
      //   ],
      //   kResponsibleInstitution: 'وزارة التربية والتعليم',
      //   kVoting: {
      //     kAgree: 68712,
      //     kDisagree: 2753,
      //   },
      // });

      final onGoingRound = await _firestore
          .collection(parliamentRoundsCollection)
          .where(kStatus, isEqualTo: kOngoingStatus)
          .limit(1)
          .get();

      if (onGoingRound.docs.isNotEmpty) {
        final onGoingRoundDoc = onGoingRound.docs.first;
        List<ParliamentProjectModel> projectsList =
            await getRoundProjectsByRoundId(onGoingRoundDoc.id);

        return Future.value(ParliamentRoundModel.fromJson(
          onGoingRoundDoc.id,
          onGoingRoundDoc.data(),
          projectsList,
        ));
      } else {
        return Future.value(ParliamentRoundModel.emptyObj());
      }
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in getOngoingRound');
      return Future.value(ParliamentRoundModel.emptyObj());
    }
  }

  @override
  Future<List<ParliamentRoundModel>> getArchivedRounds() async {
    try {
      final rounds = await _firestore
          .collection(parliamentRoundsCollection)
          .where(kStatus, isEqualTo: kArchivedStatus)
          .get();

      List<ParliamentRoundModel> roundsList = [];
      for (var round in rounds.docs) {
        List<ParliamentProjectModel> projectsList =
            await getRoundProjectsByRoundId(round.id);
        roundsList.add(ParliamentRoundModel.fromJson(
            round.id, round.data(), projectsList));
      }
      return Future.value(roundsList);
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in getArchivedRounds');
      return Future.value([]);
    }
  }

  @override
  Future<ParliamentRoundModel> getOngoingRoundInfo() async {
    try {
      final onGoingRound = await _firestore
          .collection(parliamentRoundsCollection)
          .where(kStatus, isEqualTo: kOngoingStatus)
          .limit(1)
          .get();

      if (onGoingRound.docs.isNotEmpty) {
        final onGoingRoundDoc = onGoingRound.docs.first;

        return Future.value(ParliamentRoundModel.fromJson(
          onGoingRoundDoc.id,
          onGoingRoundDoc.data(),
        ));
      } else {
        return Future.value(ParliamentRoundModel.emptyObj());
      }
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in getOngoingRoundInfo');
      return Future.value(ParliamentRoundModel.emptyObj());
    }
  }

  @override
  Future<List<ParliamentProjectModel>> getRoundProjectsByRoundId(
      String roundId) async {
    try {
      final projectsQuery = await _firestore
          .collection(parliamentRoundsCollection)
          .doc(roundId)
          .collection(projectsSubCollection)
          .get();

      List<ParliamentProjectModel> projectsList = [];

      for (var project in projectsQuery.docs) {
        projectsList
            .add(ParliamentProjectModel.fromJson(project.id, project.data()));
      }

      // sort projects by project number
      projectsList.sort((a, b) => a.projectNumber.compareTo(b.projectNumber));

      return Future.value(projectsList);
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in getRoundProjectsByRoundId');
      return Future.value([]);
    }
  }

  @override
  Future<Map<String, dynamic>> voteForProject(
      String roundId, String projectId, String vote) async {
    try {
      final projectDoc = await _firestore
          .collection(parliamentRoundsCollection)
          .doc(roundId)
          .collection(projectsSubCollection)
          .doc(projectId)
          .get();

      if (projectDoc.exists) {
        final projectData = projectDoc.data() as Map<String, dynamic>;
        int agree = projectData[kVoting][kAgree];
        int disagree = projectData[kVoting][kDisagree];

        if (vote == kAgree) {
          agree++;
        } else {
          disagree++;
        }

        await _firestore
            .collection(parliamentRoundsCollection)
            .doc(roundId)
            .collection(projectsSubCollection)
            .doc(projectId)
            .update({
          kVoting: {
            kAgree: agree,
            kDisagree: disagree,
          }
        });

        return Future.value({'success': true});
      } else {
        return Future.value({'success': false});
      }
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in voteForProject');
      return Future.value({'success': false});
    }
  }
}
