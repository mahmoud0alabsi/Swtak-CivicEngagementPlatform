import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/municipality_suggestion_entity.dart';

abstract class IMunicipalitySuggestionsRepo {
  Future<List<MunicipalitySuggestionEntity>> getAllMunicipalitySuggestions();
  Future<void> toggleUpvoteMunicipalitySuggestion(
      String suggestionId, String uid);
  Future<void> addCommentToMunicipalitySuggestion(
    String suggestionId,
    String uid,
    String name,
    DateTime dateOfComment,
    String comment,
  );
  Future<void> postSuggestion(
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
