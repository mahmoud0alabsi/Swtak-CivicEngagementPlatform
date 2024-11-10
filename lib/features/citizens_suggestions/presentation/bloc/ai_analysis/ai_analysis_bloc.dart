import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/repositories/ai_suggestions_repo_impl.dart';
import 'package:meta/meta.dart';

part 'ai_analysis_event.dart';
part 'ai_analysis_state.dart';

class AiAnalysisBloc extends Bloc<AiAnalysisEvent, AiAnalysisState> {
  AISuggestionsRepoImpl aiSuggestionsRepoImpl = AISuggestionsRepoImpl();
  AiAnalysisBloc({
    required String type,
  }) : super(AiAnalysisInitial()) {
    on<GetAiAnalysis>(_onGetAiAnalysis);
    add(GetAiAnalysis(type));
  }

  Future<void> _onGetAiAnalysis(
      GetAiAnalysis event, Emitter<AiAnalysisState> emit) async {
    emit(AiAnalysisLoading());
    try {
      String aiSuggestion =
          await aiSuggestionsRepoImpl.getAISuggestion(event.type);
      emit(AiAnalysisLoaded(aiSuggestion));
    } catch (e) {
      emit(AiAnalysisError());
    }
  }
}
