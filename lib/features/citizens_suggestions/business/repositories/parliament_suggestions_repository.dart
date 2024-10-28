import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/suggestion_entity.dart';

abstract class IParliamentSuggestionsRepo {
  Future<List<SuggestionEntity>> getAllParliamentSuggestions();
  Future<void> toggleUpvoteParliamentSuggestion(
      String suggestionId, String uid);
  Future<void> addCommentToParliamentSuggestion(
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
  );
}
