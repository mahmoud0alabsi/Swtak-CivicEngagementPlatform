part of 'ai_analysis_bloc.dart';

@immutable
sealed class AiAnalysisEvent {}

final class GetAiAnalysis extends AiAnalysisEvent {
  final String type;

  GetAiAnalysis(this.type);
}