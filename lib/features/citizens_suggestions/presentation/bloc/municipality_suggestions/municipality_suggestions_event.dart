part of 'municipality_suggestions_bloc.dart';

@immutable
sealed class MunicipalitySuggestionsEvent {}

class LoadMunicipalitySuggestions extends MunicipalitySuggestionsEvent {}

class ToggleUpvoteMunicipalitySuggestion extends MunicipalitySuggestionsEvent {
  final String suggestionId;
  final String uid;

  ToggleUpvoteMunicipalitySuggestion(this.suggestionId, this.uid);
}

class AddCommentToMunicipalitySuggestion extends MunicipalitySuggestionsEvent {
  final String suggestionId;
  final String uid;
  final String name;
  final DateTime dateOfComment;
  final String comment;

  AddCommentToMunicipalitySuggestion(
    this.suggestionId,
    this.uid,
    this.name,
    this.dateOfComment,
    this.comment,
  );
}

class GetMyMunicipalitySuggestions extends MunicipalitySuggestionsEvent {
  final String uid;

  GetMyMunicipalitySuggestions(this.uid);
}

class PostMunicipalitySuggestion extends MunicipalitySuggestionsEvent {
  final String uid;
  final String name;
  final String title;
  final String details;
  final DateTime dateOfPost;
  final String type;
  final List<String> tags;
  final String governorate;
  final String area;
  final String municipality;

  PostMunicipalitySuggestion({
    required this.uid,
    required this.name,
    required this.title,
    required this.details,
    required this.dateOfPost,
    required this.type,
    required this.tags,
    required this.governorate,
    required this.area,
    required this.municipality,
  });
}
