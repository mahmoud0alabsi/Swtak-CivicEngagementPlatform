import 'package:citizens_voice_app/core/date_formatter.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/parliament_suggestions/parliament_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/pages/suggestion_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuggestionCard extends StatefulWidget {
  final ParliamentSuggestionsBloc bloc;
  final SuggestionEntity suggestion;

  const SuggestionCard({
    super.key,
    required this.bloc,
    required this.suggestion,
  });

  @override
  SuggestionCardState createState() => SuggestionCardState();
}

class SuggestionCardState extends State<SuggestionCard> {
  late ParliamentSuggestionsBloc bloc;
  late SuggestionEntity suggestion;
  double buttonWidth = 85.0;
  double buttonHeight = 27.0;
  double upvoteButtonWidth = 72.3;
  double upvoteButtonHeight = 24.63;

  @override
  void initState() {
    super.initState();
    bloc = widget.bloc;
    suggestion = widget.suggestion;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE9E9E9),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        suggestion.name[0],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        suggestion.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        getSuggestionDateFormatted(suggestion.dateOfPost),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SuggestionDetailsPage(
                        bloc: bloc,
                        suggestion: suggestion,
                      ),
                    ),
                  );
                },
                child: Text(
                  suggestion.title,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                suggestion.details,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<ParliamentSuggestionsBloc>().add(
                            ToggleUpvoteParliamentSuggestion(
                              suggestion.id,
                              context.read<UserManagerBloc>().user.uid,
                            ),
                          );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            suggestion.upvoters.contains(
                              context.read<UserManagerBloc>().user.uid,
                            )
                                ? 'assets/icons/upvote_filled.svg'
                                : 'assets/icons/upvote_stroke.svg',
                            width: 15,
                            height: 15,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.surfaceContainer,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            width: 1,
                            height: upvoteButtonHeight - 10,
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            suggestion.upvotesCount.toString(),
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: buttonHeight,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SuggestionDetailsPage(
                              bloc: bloc,
                              suggestion: suggestion,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      iconAlignment: IconAlignment.end,
                      label: Text(
                        'عرض المزيد',
                        style: TextStyle(
                          fontSize: 8,
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        size: 11,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
