part of 'parliament_suggestions_bloc.dart';

@immutable
sealed class ParliamentSuggestionsEvent {}

class LoadParliamentSuggestions extends ParliamentSuggestionsEvent {}

class ToggleUpvoteParliamentSuggestion extends ParliamentSuggestionsEvent {
  final String suggestionId;
  final String uid;

  ToggleUpvoteParliamentSuggestion(this.suggestionId, this.uid);
}

class AddCommentToParliamentSuggestion extends ParliamentSuggestionsEvent {
  final String suggestionId;
  final String uid;
  final String name;
  final DateTime dateOfComment;
  final String comment;

  AddCommentToParliamentSuggestion(
    this.suggestionId,
    this.uid,
    this.name,
    this.dateOfComment,
    this.comment,
  );
}

class GetMySuggestions extends ParliamentSuggestionsEvent {
  final String uid;

  GetMySuggestions(this.uid);
}

class PostSuggestion extends ParliamentSuggestionsEvent {
  final String uid;
  final String name;
  final String title;
  final String details;
  final DateTime dateOfPost;
  final String type;
  final List<String> tags;

  PostSuggestion({
    required this.uid,
    required this.name,
    required this.title,
    required this.details,
    required this.dateOfPost,
    required this.type,
    required this.tags,
  });
}
