import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/parliament_suggestions/parliament_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../SuggestionCards.dart';
import '../addnewsug.dart';

Widget buildParliamentTab(BuildContext context) {
  return BlocConsumer<ParliamentSuggestionsBloc, ParliamentSuggestionsState>(
    listener: (context, state) {
      if (state is ParliamentSuggestionsError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    },
    builder: (context, state) {
      if (state is ParliamentSuggestionsLoading ||
          state is ParliamentSuggestionsInitial) {
        return const LoadingSpinner();
      }

      List<SuggestionEntity> suggestions =
          context.read<ParliamentSuggestionsBloc>().suggestions;
      // sort suggestions by upvotes count
      suggestions.sort((a, b) => b.upvotesCount.compareTo(a.upvotesCount));

      return ListView(
        children: [
          const filtercard(),
          const SizedBox(height: 12),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return SuggestionCard(
                bloc: context.read<ParliamentSuggestionsBloc>(),
                suggestion: suggestions[index],
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      );
    },
  );
}
