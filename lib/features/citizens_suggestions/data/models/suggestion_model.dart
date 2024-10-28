import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuggestionModel extends SuggestionEntity {
  SuggestionModel({
    required super.id,
    required super.uid,
    required super.name,
    required super.title,
    required super.details,
    required super.dateOfPost,
    required super.type,
    required super.tags,
    required super.upvotesCount,
    required super.upvoters,
    required super.comments,
  });

  factory SuggestionModel.fromJson(String id, Map<String, dynamic> json) {
    try {
      return SuggestionModel(
        id: id,
        uid: json[kUid],
        name: json[kName],
        title: json[kTitle],
        details: json[kDetails],
        dateOfPost: json[kDateOfPost].toDate(),
        type: json[kType],
        tags: List<String>.from(json[kTags]),
        upvotesCount: json[kUpvotesCount],
        upvoters: List<String>.from(json[kUpvoters]),
        comments: List<Map<String, dynamic>>.from(json[kComments]),
      );
    } catch (e) {
      throw Exception('Error parsing suggestion model - fromJson: $e');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      kUid: uid,
      kName: name,
      kTitle: title,
      kDetails: details,
      kDateOfPost: dateOfPost,
      kType: type,
      kTags: tags,
      kUpvotesCount: upvotesCount,
      kUpvoters: upvoters,
      kComments: comments,
    };
  }

  static List<SuggestionModel> fromSnapshot(
      QuerySnapshot<Map<String, dynamic>> suggestions) {
    try {
      return suggestions.docs
          .map((doc) => SuggestionModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error parsing suggestion model - fromSnapshot :$e');
    }
  }
}
