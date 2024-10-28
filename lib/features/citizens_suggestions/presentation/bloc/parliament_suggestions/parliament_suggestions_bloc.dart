import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/const.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/models/suggestion_model.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/data/repositories/parliament_suggestions_repo_impl.dart';
import 'package:flutter/material.dart';

part 'parliament_suggestions_event.dart';
part 'parliament_suggestions_state.dart';

class ParliamentSuggestionsBloc
    extends Bloc<ParliamentSuggestionsEvent, ParliamentSuggestionsState> {
  ParliamentSuggestionsRepoImpl parliamentSuggestionsRepoImpl =
      ParliamentSuggestionsRepoImpl();
  List<SuggestionEntity> suggestions = [];
  List<SuggestionEntity> mySuggestions = [];

  ParliamentSuggestionsBloc() : super(ParliamentSuggestionsInitial()) {
    on<LoadParliamentSuggestions>(_onLoadParliamentSuggestions);
    on<ToggleUpvoteParliamentSuggestion>(_onToggleUpvoteParliamentSuggestion);
    on<AddCommentToParliamentSuggestion>(_onAddCommentToParliamentSuggestion);
    on<GetMySuggestions>(_onGetMySuggestions);
    on<PostSuggestion>(_onPostSuggestion);

    add(LoadParliamentSuggestions());
  }

  void _onLoadParliamentSuggestions(LoadParliamentSuggestions event,
      Emitter<ParliamentSuggestionsState> emit) async {
    emit(ParliamentSuggestionsLoading());
    try {
      suggestions =
          await parliamentSuggestionsRepoImpl.getAllParliamentSuggestions();
      emit(ParliamentSuggestionsLoaded());
    } catch (e) {
      emit(ParliamentSuggestionsError(
          'حدث خطأ عند تحميل المقترحات في قسم النواب، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onToggleUpvoteParliamentSuggestion(
      ToggleUpvoteParliamentSuggestion event,
      Emitter<ParliamentSuggestionsState> emit) async {
    try {
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

      await parliamentSuggestionsRepoImpl.toggleUpvoteParliamentSuggestion(
          event.suggestionId, event.uid);
      emit(ParliamentSuggestionsUpvoted());
    } catch (e) {
      emit(ParliamentSuggestionsError(
          'حدث خطأ عند التصويت على المقترح، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onAddCommentToParliamentSuggestion(
      AddCommentToParliamentSuggestion event,
      Emitter<ParliamentSuggestionsState> emit) async {
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

      await parliamentSuggestionsRepoImpl.addCommentToParliamentSuggestion(
        event.suggestionId,
        event.uid,
        event.name,
        event.dateOfComment,
        event.comment,
      );
      emit(ParliamentSuggestionsCommented());
    } catch (e) {
      emit(ParliamentSuggestionsError(
          'حدث خطأ عند إضافة التعليق، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onGetMySuggestions(
      GetMySuggestions event, Emitter<ParliamentSuggestionsState> emit) {
    emit(ParliamentMySuggestionsLoading());
    try {
      mySuggestions = suggestions
          .where((suggestion) => suggestion.uid == event.uid)
          .toList();
      emit(ParliamentMySuggestionsLoaded());
    } catch (e) {
      emit(ParliamentSuggestionsError(
          'حدث خطأ عند تحميل مقترحاتك، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onPostSuggestion(
      PostSuggestion event, Emitter<ParliamentSuggestionsState> emit) async {
    emit(PostingSuggestion());
    try {
      String postId = await parliamentSuggestionsRepoImpl.postSuggestion(
        event.uid,
        event.name,
        event.title,
        event.details,
        event.dateOfPost,
        event.type,
        event.tags,
      );

      // add the suggestion to the list of suggestions
      suggestions.add(SuggestionModel(
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
      ));

      emit(SuggestionPosted());
    } catch (e) {
      emit(SuggestionPostError(
          'حدث خطأ عند نشر المقترح، يرجى المحاولة مرة أخرى'));
    }
  }
}
