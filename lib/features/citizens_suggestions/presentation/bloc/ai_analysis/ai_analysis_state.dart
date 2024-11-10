part of 'ai_analysis_bloc.dart';

@immutable
sealed class AiAnalysisState {}

final class AiAnalysisInitial extends AiAnalysisState {}

final class AiAnalysisLoading extends AiAnalysisState {}

final class AiAnalysisLoaded extends AiAnalysisState {
  final String aiSuggestion;

  AiAnalysisLoaded(this.aiSuggestion);
}

final class AiAnalysisError extends AiAnalysisState {}
