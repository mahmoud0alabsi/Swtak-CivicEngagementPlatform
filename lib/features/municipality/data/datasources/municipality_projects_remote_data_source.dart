import 'package:citizens_voice_app/core/errors/error_handler.dart';
import 'package:citizens_voice_app/features/municipality/const.dart';
import 'package:citizens_voice_app/features/municipality/data/models/municipality_project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IMunicipalityProjectsDataSource {
  Future<List<MunicipalityProjectModel>> getOngoingProjects();
  Future<List<MunicipalityProjectModel>> getArchivedProjects();
  Future<Map<String, dynamic>> voteForProject(String projectId, String vote);
  Future<void> addCommentToProject(
      String projectId, String comment, String commenter, String commenterId);
}

class MunicipalityProjectsRemoteDataSourceImpl
    implements IMunicipalityProjectsDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Singleton
  static final MunicipalityProjectsRemoteDataSourceImpl _instance =
      MunicipalityProjectsRemoteDataSourceImpl._internal();

  factory MunicipalityProjectsRemoteDataSourceImpl() {
    return _instance;
  }

  MunicipalityProjectsRemoteDataSourceImpl._internal();

  @override
  Future<List<MunicipalityProjectModel>> getOngoingProjects() async {
    try {
      final onGoingProjects = await _firestore
          .collection(municipalityProjectsCollection)
          .where(kIsFinished, isEqualTo: false)
          .get();

      if (onGoingProjects.docs.isNotEmpty) {
        return onGoingProjects.docs
            .map((project) => MunicipalityProjectModel.fromJson(
                  project.id,
                  project.data(),
                ))
            .toList();
      } else {
        return Future.value([]);
      }
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason:
              'Error in getOngoingProjects - MunicipalityProjectsDataSource');
      return Future.value([]);
    }
  }

  @override
  Future<List<MunicipalityProjectModel>> getArchivedProjects() async {
    try {
      final projects = await _firestore
          .collection(municipalityProjectsCollection)
          .where(kIsFinished, isEqualTo: true)
          .get();

      if (projects.docs.isNotEmpty) {
        return projects.docs
            .map((project) => MunicipalityProjectModel.fromJson(
                  project.id,
                  project.data(),
                ))
            .toList();
      } else {
        return Future.value([]);
      }
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason:
              'Error in getArchivedProjects - MunicipalityProjectsDataSource');
      return Future.value([]);
    }
  }

  @override
  Future<Map<String, dynamic>> voteForProject(
      String projectId, String vote) async {
    try {
      final projectDoc =
          _firestore.collection(municipalityProjectsCollection).doc(projectId);
      await _firestore.runTransaction((transaction) async {
        final project = await transaction.get(projectDoc);
        if (!project.exists) {
          return Future.value({'success': false});
        }

        var agree = project.data()?[kVoting][kAgree];
        var disagree = project.data()?[kVoting][kDisagree];
        if (vote == kAgree) {
          agree++;
          transaction.update(projectDoc, {
            kVoting: {
              kAgree: agree,
              kDisagree: disagree,
            }
          });
        } else {
          disagree++;
          transaction.update(projectDoc, {
            kVoting: {
              kAgree: agree,
              kDisagree: disagree,
            }
          });
        }
      });

      return Future.value({'success': true});
      // await _firestore
      //     .collection(municipalityProjectsCollection)
      //     .doc(projectId)
      //     .update({
      //   kVoting: {
      //     kAgree: vote == kAgree ? FieldValue.increment(1) : 0,
      //     kDisagree: vote == kDisagree ? FieldValue.increment(1) : 0,
      //   }
      // });

      // return Future.value({
      //   'status': 'success',
      //   'message': 'تم التصويت بنجاح، شكراً لك على مشاركتك',
      // });
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason: 'Error in voteForProject - MunicipalityProjectsDataSource');
      return Future.value({});
    }
  }

  @override
  Future<void> addCommentToProject(String projectId, String comment,
      String commenter, String commenterId) async {
    try {
      return _firestore
          .collection(municipalityProjectsCollection)
          .doc(projectId)
          .update({
        kComments: FieldValue.arrayUnion([
          {
            kComment: comment,
            kCommentDate: DateTime.now(),
            kCommenter: commenter,
            kCommenterId: commenterId,
          },
        ]),
      });
    } catch (e) {
      ErrorHandler.crashlyticsLogError(e, StackTrace.current,
          reason:
              'Error in addCommentToProject - MunicipalityProjectsDataSource');
    }
  }
}



// String kTitle = 'title';
// String kDetails = 'details';
// String kDateOfPost = 'date_of_post';
// String kDurationOfAvailability = 'duration_of_availability';
// String kType = 'type';
// String kTags = 'tags';
// String kVoting = 'voting';
// String kAgree = 'agree';
// String kDisagree = 'disagree';
// String kIsFinished = 'is_finished';
// String kProjectNumber = 'project_number';

      // await _firestore.collection(municipalityProjectsCollection).add({
      //   kTitle: 'تجديد الطرق',
      //   kDetails: 'تجديد الطرق في الحي الشرقي',
      //   kDateOfPost: DateTime.now(),
      //   kDurationOfAvailability: 30,
      //   kType: 'طرق',
      //   kTags: ['تجديد', 'طرق'],
      //   kVoting: {
      //     kAgree: 0,
      //     kDisagree: 0,
      //   },
      //   kIsFinished: false,
      //   kProjectNumber: 1,
      // });

      // await _firestore.collection(municipalityProjectsCollection).add({
      //   kTitle: 'إضافة مواقف سيارات',
      //   kDetails: 'إضافة مواقف سيارات في الحي الشرقي',
      //   kDateOfPost: DateTime.now(),
      //   kDurationOfAvailability: 30,
      //   kType: 'خدمات',
      //   kTags: ['إضافة', 'مواقف', 'سيارات'],
      //   kVoting: {
      //     kAgree: 0,
      //     kDisagree: 0,
      //   },
      //   kIsFinished: false,
      //   kProjectNumber: 2,
      // });

      // await _firestore.collection(municipalityProjectsCollection).add({
      //   kTitle: 'تجديد الإنارة',
      //   kDetails: 'تجديد الإنارة في الحي الشرقي',
      //   kDateOfPost: DateTime.now(),
      //   kDurationOfAvailability: 30,
      //   kType: 'إنارة',
      //   kTags: ['تجديد', 'إنارة'],
      //   kVoting: {
      //     kAgree: 0,
      //     kDisagree: 0,
      //   },
      //   kIsFinished: false,
      //   kProjectNumber: 3,
      // });

      // await _firestore.collection(municipalityProjectsCollection).add({
      //   kTitle: 'بناء ملعب رياضي',
      //   kDetails: 'بناء ملعب رياضي في الحي الشرقي',
      //   kDateOfPost: DateTime.now(),
      //   kDurationOfAvailability: 30,
      //   kType: 'رياضة',
      //   kTags: ['بناء', 'ملعب', 'رياضي'],
      //   kVoting: {
      //     kAgree: 0,
      //     kDisagree: 0,
      //   },
      //   kIsFinished: false,
      //   kProjectNumber: 4,
      // });

      // await _firestore.collection(municipalityProjectsCollection).add({
      //   kTitle: 'إصلاح خطوط الكهرباء',
      //   kDetails: 'إصلاح خطوط الكهرباء في الحي الشرقي',
      //   kDateOfPost: DateTime.now(),
      //   kDurationOfAvailability: 30,
      //   kType: 'كهرباء',
      //   kTags: ['إصلاح', 'خطوط', 'كهرباء'],
      //   kVoting: {
      //     kAgree: 0,
      //     kDisagree: 0,
      //   },
      //   kIsFinished: false,
      //   kProjectNumber: 5,
      // });