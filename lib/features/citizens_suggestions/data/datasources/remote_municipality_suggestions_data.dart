import 'package:citizens_voice_app/features/citizens_suggestions/const.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/models/municipality_suggestion_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IRemoteMunicipalitySuggestionsData {
  Future<List<MunicipalitySuggestionModel>> getAllMunicipalitySuggestions();
  Future<void> toggleUpvoteMunicipalitySuggestion(
      String suggestionId, String uid);
  Future<void> addCommentToMunicipalitySuggestion(
    String suggestionId,
    String uid,
    String name,
    DateTime dateOfComment,
    String comment,
  );

  Future<String> postSuggestion(
    String uid,
    String name,
    String title,
    String details,
    DateTime dateOfPost,
    String type,
    List<String> tags,
    String governorate,
    String area,
    String municipality,
  );
}

class RemoteMunicipalitySuggestionsData
    implements IRemoteMunicipalitySuggestionsData {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Singleton
  static final RemoteMunicipalitySuggestionsData _instance =
      RemoteMunicipalitySuggestionsData._internal();

  factory RemoteMunicipalitySuggestionsData() => _instance;

  RemoteMunicipalitySuggestionsData._internal();

  @override
  Future<List<MunicipalitySuggestionModel>>
      getAllMunicipalitySuggestions() async {
    final suggestions = await firestore
        .collection(municipalitySuggestionsCollection)
        .where(kDateOfPost,
            isGreaterThan: DateTime.now()
                .subtract(Duration(days: kMunicipalitySuggestionActiveTime)))
        .get();
    return MunicipalitySuggestionModel.fromSnapshot(suggestions);
  }

  @override
  Future<void> toggleUpvoteMunicipalitySuggestion(
      String suggestionId, String uid) async {
    final suggestionRef = firestore
        .collection(municipalitySuggestionsCollection)
        .doc(suggestionId);
    await firestore.runTransaction((transaction) async {
      final suggestion = await transaction.get(suggestionRef);
      if (!suggestion.exists) {
        throw Exception('Suggestion does not exist!');
      }

      // check if user already upvoted
      final upvoters = suggestion.data()?[kUpvoters];
      if (upvoters.contains(uid)) {
        // remove upvote
        final upvotesCount = suggestion.data()?[kUpvotesCount] - 1;
        upvoters.remove(uid);
        transaction.update(suggestionRef, {
          kUpvotesCount: upvotesCount,
          kUpvoters: upvoters,
        });
      } else {
        // add upvote
        final upvotesCount = suggestion.data()?[kUpvotesCount] + 1;
        upvoters.add(uid);
        transaction.update(suggestionRef, {
          kUpvotesCount: upvotesCount,
          kUpvoters: upvoters,
        });
      }
    });
  }

  @override
  Future<void> addCommentToMunicipalitySuggestion(
    String suggestionId,
    String uid,
    String name,
    DateTime dateOfComment,
    String comment,
  ) async {
    final suggestionRef = firestore
        .collection(municipalitySuggestionsCollection)
        .doc(suggestionId);
    await firestore.runTransaction((transaction) async {
      final suggestion = await transaction.get(suggestionRef);
      if (!suggestion.exists) {
        throw Exception('Suggestion does not exist!');
      }

      final comments = suggestion.data()?[kComments];
      comments.add({
        kUid: uid,
        kName: name,
        kDateOfComment: dateOfComment,
        kComment: comment,
      });

      transaction.update(suggestionRef, {kComments: comments});
    });
  }

  @override
  Future<String> postSuggestion(
    String uid,
    String name,
    String title,
    String details,
    DateTime dateOfPost,
    String type,
    List<String> tags,
    String governorate,
    String area,
    String municipality,
  ) async {
    try {
      final doc =
          await firestore.collection(municipalitySuggestionsCollection).add({
        kUid: uid,
        kName: name,
        kTitle: title,
        kDetails: details,
        kDateOfPost: dateOfPost,
        kType: type,
        kTags: tags,
        kGovernorate: governorate,
        kArea: area,
        kMunicipality: municipality,
        kUpvotesCount: 0,
        kUpvoters: [],
        kComments: [],
      });

      return doc.id;
    } catch (e) {
      throw Exception('Error posting suggestion: $e');
    }
  }
}




// await firestore.collection(municipalitySuggestionsCollection).add({
//       kUid: 'ohPnSiM2QHUOGa4eEYp7ZYMRol72',
//       kName: 'محمود',
//       kTitle: 'إصلاح حفر في شارع الجامعة',
//       kDetails:
//           'إصلاح حفر في شارع الجامعة، إصلاح حفر في شارع الجامعة، إصلاح حفر في شارع الجامعة، إصلاح حفر في شارع الجامعة، إصلاح حفر في شارع الجامعة.',
//       kDateOfPost: DateTime.now(),
//       kType: 'طرق',
//       kTags: ['طرق'],
//       kUpvotesCount: 183,
//       kUpvoters: [
//         'dsadSiM2QHUOGa4eEYp7ZYMRol72',
//       ],
//       kComments: [
//         {
//           kUid: 'ohPnSiMjhtre7ZYMRol72',
//           kName: 'محمد',
//           kDateOfComment: DateTime.now(),
//           kComment: 'أنا مع هذا الإقتراح',
//         },
//       ],
//     });

//     await firestore.collection(municipalitySuggestionsCollection).add({
//       kUid: 'ohPnSiM2QHUgrreggrhtrhol72',
//       kName: 'محمد',
//       kTitle: 'إنارة شارع الجامعة',
//       kDetails:
//           'إنارة شارع الجامعة، إنارة شارع الجامعة، إنارة شارع الجامعة، إنارة شارع الجامعة، إنارة شارع الجامعة.',
//       kDateOfPost: DateTime.now().subtract(const Duration(days: 6)),
//       kType: 'طرق',
//       kTags: ['طرق'],
//       kUpvotesCount: 782,
//       kUpvoters: [
//         'ohPnSsdfsiM2QHhgh4eEYp7ZYMRol72',
//         'gfgriM2QHUOGa4eEYp7ZYMRol72',
//         'SgrehtjyGa4eEYp7ZYMRol72',
//       ],
//       kComments: [
//         {
//           kUid: 'fdsggriMjhtre7ZYMRol72',
//           kName: 'محمد',
//           kDateOfComment: DateTime.now(),
//           kComment: 'أنا مع هذا الإقتراح',
//         },
//         {
//           kUid: 'jyjregtrhytjj',
//           kName: 'أحمد',
//           kDateOfComment: DateTime.now(),
//           kComment: 'أنا ضد هذا الإقتراح',
//         },
//       ],
//     });