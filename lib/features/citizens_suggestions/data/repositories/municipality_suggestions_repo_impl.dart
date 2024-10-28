import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/municipality_suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/business/repositories/Municipality_suggestions_repository.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/datasources/remote_municipality_suggestions_data.dart';

class MunicipalitySuggestionsRepoImpl implements IMunicipalitySuggestionsRepo {
  RemoteMunicipalitySuggestionsData remoteMunicipalitySuggestionsData =
      RemoteMunicipalitySuggestionsData();

  // Singleton
  static final MunicipalitySuggestionsRepoImpl _instance =
      MunicipalitySuggestionsRepoImpl._internal();

  factory MunicipalitySuggestionsRepoImpl() => _instance;

  MunicipalitySuggestionsRepoImpl._internal();

  @override
  Future<List<MunicipalitySuggestionEntity>> getAllMunicipalitySuggestions() {
    return remoteMunicipalitySuggestionsData.getAllMunicipalitySuggestions();
  }

  @override
  Future<void> toggleUpvoteMunicipalitySuggestion(
      String suggestionId, String uid) {
    return remoteMunicipalitySuggestionsData.toggleUpvoteMunicipalitySuggestion(
        suggestionId, uid);
  }

  @override
  Future<void> addCommentToMunicipalitySuggestion(String suggestionId,
      String uid, String name, DateTime dateOfComment, String comment) {
    return remoteMunicipalitySuggestionsData.addCommentToMunicipalitySuggestion(
        suggestionId, uid, name, dateOfComment, comment);
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
      String municipality) {
    return remoteMunicipalitySuggestionsData.postSuggestion(
      uid,
      name,
      title,
      details,
      dateOfPost,
      type,
      tags,
      governorate,
      area,
      municipality,
    );
  }
}
