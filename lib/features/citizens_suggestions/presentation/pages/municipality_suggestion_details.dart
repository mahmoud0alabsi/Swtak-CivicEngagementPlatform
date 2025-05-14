import 'package:citizens_voice_app/core/date_formatter.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/business/entities/municipality_suggestion_entity.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/const.dart';
import 'package:citizens_voice_app/features/citizens_suggestions/presentation/bloc/municipality_suggestions/municipality_suggestions_bloc.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class MunicipalitySuggestionDetailsPage extends StatefulWidget {
  final MunicipalitySuggestionsBloc bloc;
  final MunicipalitySuggestionEntity suggestion;

  const MunicipalitySuggestionDetailsPage({
    super.key,
    required this.bloc,
    required this.suggestion,
  });

  @override
  MunicipalitySuggestionDetailsPageState createState() =>
      MunicipalitySuggestionDetailsPageState();
}

class MunicipalitySuggestionDetailsPageState
    extends State<MunicipalitySuggestionDetailsPage> {
  late MunicipalitySuggestionsBloc bloc;
  late MunicipalitySuggestionEntity suggestion;

  // Controller for the comment input
  final TextEditingController _commentController = TextEditingController();
  int _charCount = 0;
  String errorMsg = '';

  @override
  void initState() {
    super.initState();
    bloc = widget.bloc;
    suggestion = widget.suggestion;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Text(
              'التفاصيل',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textDirection: TextDirection.rtl,
            ),
            elevation: 0,
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.primary),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(children: [
              SingleChildScrollView(
                child: Card(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  shadowColor: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  child: Text(
                                    suggestion.name[0],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  suggestion.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Text(
                          suggestion.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          suggestion.details,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                            height: 1.7,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    bloc.add(
                                      ToggleUpvoteMunicipalitySuggestion(
                                        suggestion.id,
                                        context
                                            .read<UserManagerBloc>()
                                            .user
                                            .uid,
                                      ),
                                    );

                                    setState(() {});
                                  },
                                  child: SvgPicture.asset(
                                    suggestion.upvoters.contains(
                                      context.read<UserManagerBloc>().user.uid,
                                    )
                                        ? 'assets/icons/upvote_filled.svg'
                                        : 'assets/icons/upvote_stroke.svg',
                                    width: 20,
                                    height: 20,
                                    colorFilter: ColorFilter.mode(
                                      Theme.of(context).colorScheme.secondary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  suggestion.upvotesCount.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.chat_bubble_outline,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  size: 20,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  suggestion.comments.length.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                ),
                              ],
                            ),
                            Text(
                              getSuggestionDateFormatted(suggestion.dateOfPost),
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        const Divider(thickness: 0.25),
                        const SizedBox(height: 8),
                        // check if user has commented on this suggestion
                        if (suggestion.comments
                            .where((comment) =>
                                comment[kUid] ==
                                context.read<UserManagerBloc>().user.uid)
                            .isEmpty) ...[
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.grey[300],
                                child: Text(
                                  context
                                      .read<UserManagerBloc>()
                                      .user
                                      .fullName
                                      .split(' ')[0][0],
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: TextField(
                                              controller: _commentController,
                                              maxLength: 120,
                                              minLines: 1,
                                              maxLines: 5,
                                              onChanged: (text) {
                                                setState(() {
                                                  _charCount = text.length;
                                                  if (_charCount < 120 &&
                                                      _charCount > 0) {
                                                    errorMsg = '';
                                                  }
                                                });
                                              },
                                              decoration: const InputDecoration(
                                                hintText: 'أضف تعليق جديد',
                                                hintStyle: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey),
                                                border: InputBorder.none,
                                                counterText:
                                                    '', // Hide default character counter
                                              ),
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: _charCount > 120
                                                    ? const Color(0xFFD90429)
                                                    : Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          SizedBox(
                                            width: 50,
                                            height: 32,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFFD90429),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                padding: EdgeInsets.zero,
                                              ),
                                              onPressed: () {
                                                if (_commentController
                                                        .text.isNotEmpty &&
                                                    !(_charCount > 120)) {
                                                  bloc.add(
                                                    AddCommentToMunicipalitySuggestion(
                                                      suggestion.id,
                                                      context
                                                          .read<
                                                              UserManagerBloc>()
                                                          .user
                                                          .uid,
                                                      context
                                                          .read<
                                                              UserManagerBloc>()
                                                          .user
                                                          .fullName
                                                          .split(' ')[0],
                                                      DateTime.now(),
                                                      _commentController.text,
                                                    ),
                                                  );
                                                  setState(() {
                                                    _commentController.clear();
                                                    _charCount = 0;
                                                    errorMsg = '';
                                                  });
                                                } else if (_charCount > 120) {
                                                  setState(() {
                                                    errorMsg =
                                                        'الحد الأقصى 120 حرف';
                                                  });
                                                } else {
                                                  setState(() {
                                                    errorMsg =
                                                        'الرجاء إضافة تعليق';
                                                  });
                                                }
                                              },
                                              child: Text(
                                                'تعليق',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          errorMsg,
                                          style: const TextStyle(
                                              color: Color(0xFFD90429),
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '120/$_charCount',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: _charCount > 120
                                                ? const Color(0xFFD90429)
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                        ],
                        ...suggestion.comments.map((comment) {
                          return _commentSection(
                            comment,
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              if (bloc.state is MunicipalitySuggestionsUpvoting)
                Container(
                  color: Colors.white.withOpacity(0.5),
                  child: const LoadingSpinner(),
                ),
            ]),
          ),
        );
      },
    );
  }

  Widget _commentSection(Map<String, dynamic> comment) {
    String firstLetter = comment[kName].isNotEmpty ? comment[kName][0] : '';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            const SizedBox(height: 7),
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: Text(
                firstLetter,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF2FC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment[kName],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      getSuggestionDateFormatted(
                          comment[kDateOfComment].runtimeType == Timestamp
                              ? comment[kDateOfComment].toDate()
                              : comment[kDateOfComment]),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  comment[kComment],
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
