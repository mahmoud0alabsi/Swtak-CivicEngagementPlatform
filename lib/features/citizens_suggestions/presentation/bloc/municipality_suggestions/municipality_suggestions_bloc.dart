import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/municipality_suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/const.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/models/municipality_suggestion_model.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/repositories/municipality_suggestions_repo_impl.dart';
import 'package:flutter/material.dart';
part 'municipality_suggestions_event.dart';
part 'municipality_suggestions_state.dart';

class MunicipalitySuggestionsBloc
    extends Bloc<MunicipalitySuggestionsEvent, MunicipalitySuggestionsState> {
  MunicipalitySuggestionsRepoImpl municipalitySuggestionsRepoImpl =
      MunicipalitySuggestionsRepoImpl();
  List<MunicipalitySuggestionEntity> suggestions = [];
  List<MunicipalitySuggestionEntity> mySuggestions = [];

  MunicipalitySuggestionsBloc() : super(MunicipalitySuggestionsInitial()) {
    on<LoadMunicipalitySuggestions>(_onLoadMunicipalitySuggestions);
    on<ToggleUpvoteMunicipalitySuggestion>(
        _onToggleUpvoteMunicipalitySuggestion);
    on<AddCommentToMunicipalitySuggestion>(
        _onAddCommentToMunicipalitySuggestion);
    on<GetMyMunicipalitySuggestions>(_onGetMyMunicipalitySuggestions);
    on<PostMunicipalitySuggestion>(_onPostMunicipalitySuggestion);
    on<FilterMunicipalitySuggestions>(_onFilterMunicipalitySuggestions);

    add(LoadMunicipalitySuggestions());
  }

  void _onLoadMunicipalitySuggestions(LoadMunicipalitySuggestions event,
      Emitter<MunicipalitySuggestionsState> emit) async {
    emit(MunicipalitySuggestionsLoading());
    try {
      suggestions =
          await municipalitySuggestionsRepoImpl.getAllMunicipalitySuggestions();
      emit(MunicipalitySuggestionsLoaded());
    } catch (e) {
      emit(MunicipalitySuggestionsError(
          'حدث خطأ عند تحميل المقترحات في قسم البلدية، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onToggleUpvoteMunicipalitySuggestion(
      ToggleUpvoteMunicipalitySuggestion event,
      Emitter<MunicipalitySuggestionsState> emit) async {
    emit(MunicipalitySuggestionsUpvoting());
    try {
      await municipalitySuggestionsRepoImpl.toggleUpvoteMunicipalitySuggestion(
          event.suggestionId, event.uid);

      // toggle upvote for the suggestion
      for (var suggestion in suggestions) {
        if (suggestion.id == event.suggestionId) {
          if (suggestion.upvoters.contains(event.uid)) {
            suggestion.upvoters.remove(event.uid);
            suggestion.upvotesCount--;
          } else {
            suggestion.upvoters.add(event.uid);
            suggestion.upvotesCount++;
          }
        }
      }

      emit(MunicipalitySuggestionsUpvoted(suggestions));
    } catch (e) {
      emit(MunicipalitySuggestionsError(
          'حدث خطأ عند التصويت على المقترح، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onAddCommentToMunicipalitySuggestion(
      AddCommentToMunicipalitySuggestion event,
      Emitter<MunicipalitySuggestionsState> emit) async {
    try {
      // add comment to the suggestion
      for (var suggestion in suggestions) {
        if (suggestion.id == event.suggestionId) {
          suggestion.comments.add({
            kUid: event.uid,
            kName: event.name,
            kDateOfComment: event.dateOfComment,
            kComment: event.comment,
          });
        }
      }

      await municipalitySuggestionsRepoImpl.addCommentToMunicipalitySuggestion(
        event.suggestionId,
        event.uid,
        event.name,
        event.dateOfComment,
        event.comment,
      );
      emit(MunicipalitySuggestionsCommented());
    } catch (e) {
      emit(MunicipalitySuggestionsError(
          'حدث خطأ عند إضافة التعليق، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onGetMyMunicipalitySuggestions(GetMyMunicipalitySuggestions event,
      Emitter<MunicipalitySuggestionsState> emit) {
    emit(MunicipalityMySuggestionsLoading());
    try {
      mySuggestions = suggestions
          .where((suggestion) => suggestion.uid == event.uid)
          .toList();
      emit(MunicipalityMySuggestionsLoaded());
    } catch (e) {
      emit(MunicipalitySuggestionsError(
          'حدث خطأ عند تحميل مقترحاتك، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onPostMunicipalitySuggestion(PostMunicipalitySuggestion event,
      Emitter<MunicipalitySuggestionsState> emit) async {
    emit(PostingMunicipalitySuggestion());
    try {
      String postId = await municipalitySuggestionsRepoImpl.postSuggestion(
        event.uid,
        event.name,
        event.title,
        event.details,
        event.dateOfPost,
        event.type,
        event.tags,
        event.governorate,
        event.area,
        event.municipality,
      );

      // add the suggestion to the list of suggestions
      suggestions.add(MunicipalitySuggestionModel(
        id: postId,
        uid: event.uid,
        name: event.name,
        title: event.title,
        details: event.details,
        dateOfPost: event.dateOfPost,
        type: event.type,
        tags: event.tags,
        upvotesCount: 0,
        upvoters: [],
        comments: [],
        governorate: event.governorate,
        area: event.area,
        municipality: event.municipality,
      ));

      emit(MunicipalitySuggestionPosted());
    } catch (e) {
      emit(MunicipalitySuggestionPostError(
          'حدث خطأ عند نشر المقترح، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onFilterMunicipalitySuggestions(FilterMunicipalitySuggestions event,
      Emitter<MunicipalitySuggestionsState> emit) {
    emit(MunicipalitySuggestionsLoading());
    try {
      if (event.governorate == '') {
        emit(FilteredMunicipalitySuggestions(suggestions));
        return;
      }
      List<MunicipalitySuggestionEntity> filteredSuggestions = suggestions
          .where((suggestion) =>
              suggestion.governorate == event.governorate &&
              suggestion.area == event.area &&
              suggestion.municipality == event.municipality)
          .toList();
      emit(FilteredMunicipalitySuggestions(filteredSuggestions));
    } catch (e) {
      emit(MunicipalitySuggestionsError(
          'حدث خطأ عند تحميل المقترحات في قسم البلدية، يرجى المحاولة مرة أخرى'));
    }
  }
}
