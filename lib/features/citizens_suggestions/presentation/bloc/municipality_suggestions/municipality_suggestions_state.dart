part of 'municipality_suggestions_bloc.dart';

@immutable
sealed class MunicipalitySuggestionsState {}

final class MunicipalitySuggestionsInitial
    extends MunicipalitySuggestionsState {}

final class MunicipalitySuggestionsLoading
    extends MunicipalitySuggestionsState {}

final class MunicipalitySuggestionsLoaded
    extends MunicipalitySuggestionsState {}

final class MunicipalitySuggestionsError extends MunicipalitySuggestionsState {
  final String message;

  MunicipalitySuggestionsError(this.message);
}

final class MunicipalitySuggestionsUpvoted
    extends MunicipalitySuggestionsState {}

final class MunicipalitySuggestionsCommented
    extends MunicipalitySuggestionsState {}

final class MunicipalityMySuggestionsLoading
    extends MunicipalitySuggestionsState {}

final class MunicipalityMySuggestionsLoaded
    extends MunicipalitySuggestionsState {}

final class PostingMunicipalitySuggestion
    extends MunicipalitySuggestionsState {}

final class MunicipalitySuggestionPosted extends MunicipalitySuggestionsState {}

final class MunicipalitySuggestionPostError
    extends MunicipalitySuggestionsState {
  final String message;

  MunicipalitySuggestionPostError(this.message);
}

final class FilteredMunicipalitySuggestions
    extends MunicipalitySuggestionsState {
  final List<MunicipalitySuggestionEntity> suggestions;

  FilteredMunicipalitySuggestions(this.suggestions);
}
