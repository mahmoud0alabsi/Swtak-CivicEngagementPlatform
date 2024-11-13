part of 'parliament_suggestions_bloc.dart';

@immutable
sealed class ParliamentSuggestionsState {}

final class ParliamentSuggestionsInitial extends ParliamentSuggestionsState {}

final class ParliamentSuggestionsLoading extends ParliamentSuggestionsState {}

final class ParliamentSuggestionsLoaded extends ParliamentSuggestionsState {}

final class ParliamentSuggestionsError extends ParliamentSuggestionsState {
  final String message;

  ParliamentSuggestionsError(this.message);
}

final class ParliamentSuggestionsUpvoting extends ParliamentSuggestionsState {}

final class ParliamentSuggestionsUpvoted extends ParliamentSuggestionsState {}

final class ParliamentSuggestionsCommented extends ParliamentSuggestionsState {}

final class ParliamentMySuggestionsLoading extends ParliamentSuggestionsState {}

final class ParliamentMySuggestionsLoaded extends ParliamentSuggestionsState {}

final class PostingSuggestion extends ParliamentSuggestionsState {}

final class SuggestionPosted extends ParliamentSuggestionsState {}

final class SuggestionPostError extends ParliamentSuggestionsState {
  final String message;

  SuggestionPostError(this.message);
}