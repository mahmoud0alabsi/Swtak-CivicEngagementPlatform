import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/municipality_suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/municipality_suggestions/municipality_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/widgets/filter_card.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/widgets/municipality_suggestion_cards.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      if (state is MunicipalitySuggestionsLoading ||
          state is MunicipalitySuggestionsInitial) {
        return Skeletonizer(
          enabled: true,
          child: ListView(
            children: [
              const Skeleton.keep(
                child: Filtercard(
                  type: 'municipality',
                  bloc: null,
                ),
              ),
              const SizedBox(height: 12),
              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return MunicipalitySuggestionCard(
                    bloc: context.read<MunicipalitySuggestionsBloc>(),
                    suggestion: MunicipalitySuggestionEntity(
                      id: '0',
                      title: 'dummy dummy dummy',
                      details:
                          'dummy dummy dummy dummy dummy dummy \n dummy dummy dummy dummy',
                      dateOfPost: DateTime.now(),
                      upvotesCount: 0,
                      tags: [],
                      type: 'dummy',
                      comments: [],
                      name: 'dummy',
                      uid: 'dummy',
                      upvoters: [],
                      area: 'dummy',
                      governorate: 'dummy',
                      municipality: 'dummy',
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      }

      List<MunicipalitySuggestionEntity> suggestions =
          context.read<MunicipalitySuggestionsBloc>().suggestions;

      if (state is FilteredMunicipalitySuggestions) {
        suggestions = state.suggestions;
      }

      // sort suggestions by upvotes count
      suggestions.sort((a, b) => b.upvotesCount.compareTo(a.upvotesCount));

      return Stack(
        children: [
          ListView(
            children: [
              Filtercard(
                type: 'municipality',
                bloc: context.read<MunicipalitySuggestionsBloc>(),
              ),
              const SizedBox(height: 12),
              suggestions.isEmpty
                  ? Center(
                      child: Text(
                        'لا يوجد اقتراحات',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  : ListView.separated(
                      key: ValueKey(suggestions.map((e) => e.id).join()),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
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
          ),
          if (state is MunicipalitySuggestionsUpvoting)
            Container(
              color: Colors.white.withOpacity(0.5),
              child: const Center(
                child: LoadingSpinner(),
              ),
            ),
        ],
      );
    },
  );
}
