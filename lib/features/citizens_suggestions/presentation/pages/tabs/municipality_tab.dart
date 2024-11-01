import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/municipality_suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/municipality_suggestions/municipality_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/widgets/filter_card.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/widgets/municipality_suggestion_cards.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildMunicipalityTab(BuildContext context) {
  return BlocConsumer<MunicipalitySuggestionsBloc,
      MunicipalitySuggestionsState>(
    listener: (context, state) {
      if (state is MunicipalitySuggestionsError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    },
    builder: (context, state) {
      if (state is MunicipalityMySuggestionsLoading ||
          state is MunicipalitySuggestionsInitial) {
        return const LoadingSpinner();
      }

      List<MunicipalitySuggestionEntity> suggestions =
          context.read<MunicipalitySuggestionsBloc>().suggestions;

      if (suggestions.isEmpty) {
        return const Center(
          child: Text('لا يوجد اقتراحات بعد'),
        );
      }

      // sort suggestions by upvotes count
      suggestions.sort((a, b) => b.upvotesCount.compareTo(a.upvotesCount));

      return ListView(
        children: [
          const Filtercard(),
          const SizedBox(height: 12),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemCount: suggestions.length,
            itemBuilder: (context, index) {
              return MunicipalitySuggestionCard(
                bloc: context.read<MunicipalitySuggestionsBloc>(),
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
