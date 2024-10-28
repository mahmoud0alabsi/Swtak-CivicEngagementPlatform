import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/business/repositories/parliament_suggestions_repository.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/datasources/remote_parliament_suggestions_data.dart';

class ParliamentSuggestionsRepoImpl implements IParliamentSuggestionsRepo {
  RemoteParliamentSuggestionsData remoteParliamentSuggestionsData =
      RemoteParliamentSuggestionsData();

  // Singleton
  static final ParliamentSuggestionsRepoImpl _instance =
      ParliamentSuggestionsRepoImpl._internal();

  factory ParliamentSuggestionsRepoImpl() => _instance;

  ParliamentSuggestionsRepoImpl._internal();

  @override
  Future<List<SuggestionEntity>> getAllParliamentSuggestions() {
    return remoteParliamentSuggestionsData.getAllParliamentSuggestions();
  }

  @override
  Future<void> toggleUpvoteParliamentSuggestion(String suggestionId, String uid) {
    return remoteParliamentSuggestionsData
        .toggleUpvoteParliamentSuggestion(suggestionId, uid);
  }

  @override
  Future<void> addCommentToParliamentSuggestion(String suggestionId, String uid,
      String name, DateTime dateOfComment, String comment) {
    return remoteParliamentSuggestionsData.addCommentToParliamentSuggestion(
        suggestionId, uid, name, dateOfComment, comment);
  }
  
  @override
  Future<String> postSuggestion(String uid, String name, String title, String details, DateTime dateOfPost, String type, List<String> tags) {
    return remoteParliamentSuggestionsData.postSuggestion(uid, name, title, details, dateOfPost, type, tags);
  }
}
