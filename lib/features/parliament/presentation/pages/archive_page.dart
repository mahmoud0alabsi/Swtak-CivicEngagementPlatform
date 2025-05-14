import 'package:citizens_voice_app/core/date_formatter.dart';
import 'package:citizens_voice_app/core/fields_map.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/municipality/const.dart';
import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';
import 'package:citizens_voice_app/features/parliament/presentation/bloc/archived_rounds/archived_rounds_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ParliamentArchivePage extends StatefulWidget {
  const ParliamentArchivePage({super.key});

  @override
  ParliamentArchivePageState createState() => ParliamentArchivePageState();
}

class ParliamentArchivePageState extends State<ParliamentArchivePage> {
  int _expandedCardIndex = -1; // To track the currently expanded card

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchivedRoundsBloc(
        user: context.read<UserManagerBloc>().user,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: appBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.archive_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 28,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'الأرشيف',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'تصفح المشاريع السابقة ونتائج التصويت عليها من قبل المواطنين ومجلس النواب، بالاضافة الى مشاركاتك في التصويت.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                BlocConsumer<ArchivedRoundsBloc, ArchivedRoundsState>(
                  listener: (context, state) {
                    if (state is ArchivedRoundsError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ArchivedRoundsLoading ||
                        state is ArchivedRoundsInitial) {
                      return Skeletonizer(
                        enabled: true,
                        child: Column(
                          children: [
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    height: 75,
                                    width: 478,
                                    child: Skeleton.leaf(
                                      child: Card(
                                        child: ListTile(
                                          title: Text(
                                              'Item number $index as title'),
                                          subtitle: const Text('Subtitle here'),
                                          trailing: const Icon(Icons.ac_unit),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ),
                      );
                    }
                    ArchivedRoundsBloc bloc =
                        context.read<ArchivedRoundsBloc>();
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bloc.archivedRounds.length,
                      itemBuilder: (context, index) {
                        ParliamentRoundEntity round =
                            bloc.archivedRounds[index];
                        round.projects.sort((a, b) =>
                            a.projectNumber.compareTo(b.projectNumber));

                        int roundIndex = index;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'جولة رقم: ${round.roundNumber}',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              textAlign: TextAlign
                                  .right, // Ensure the text is aligned to the right
                            ),
                            const SizedBox(height: 5),
                            ...round.projects.map(
                              (project) {
                                int issueIndex = round.projects.indexWhere(
                                    (element) => element == project);
                                return Column(
                                  children: [
                                    IssueCard(
                                      issueNumber: project.projectNumber,
                                      title: project.title,
                                      voteDetails: project.details,
                                      voteDate: round.dateOfPost,
                                      voting: project.voting,
                                      myvote: project.userVote,
                                      parlvote: 'أوافق',
                                      isExpanded: _expandedCardIndex ==
                                          (roundIndex * 10 + issueIndex),
                                      icon: getProjectTypeIcon(project.type),
                                      onCardTap: () {
                                        setState(() {
                                          _expandedCardIndex =
                                              _expandedCardIndex ==
                                                      (roundIndex * 10 +
                                                          issueIndex)
                                                  ? -1
                                                  : (roundIndex * 10 +
                                                      issueIndex);
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              },
                            ),
                            const Divider(
                              height: 30.0,
                              indent: 10.0,
                              endIndent: 10.0,
                              thickness: 1,
                              color: Color.fromARGB(255, 206, 206, 206),
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined,
            color: Theme.of(context).colorScheme.primary),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'مجلس النواب',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final int issueNumber;
  final String title;
  final String voteDetails;
  final DateTime voteDate;
  final Map<String, dynamic> voting;
  final String myvote;
  final String parlvote;
  final bool isExpanded;
  final VoidCallback onCardTap;
  final String icon;

  const IssueCard({
    super.key,
    required this.issueNumber,
    required this.title,
    required this.voteDetails,
    required this.voteDate,
    required this.voting,
    required this.myvote,
    required this.parlvote,
    required this.isExpanded,
    required this.onCardTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  icon,
                  height: 34,
                  width: 34,
                  colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary, BlendMode.srcIn),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'مشروع رقم $issueNumber',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isExpanded) ...[
              const SizedBox(height: 10),
              _buildExpandedText('تفاصيل المشروع: ', voteDetails, context),
              const SizedBox(height: 9),
              _buildExpandedText(
                  'التاريخ: ', getDateFormattedWithYear(voteDate), context),
              const SizedBox(height: 9),
              if (myvote.isNotEmpty) ...[
                _buildExpandedText('نتيجة تصويتك: ', myvote, context),
                const SizedBox(height: 9),
              ],
              _buildBarGraph(
                  'تصويت المواطنين',
                  voting[kAgree] >= voting[kDisagree] ? kAgreeAr : kDisagreeAr,
                  voting[kAgree] >= voting[kDisagree]
                      ? voting[kAgree] / (voting[kAgree] + voting[kDisagree])
                      : voting[kDisagree] /
                          (voting[kAgree] + voting[kDisagree]),
                  voting[kAgree] >= voting[kDisagree]
                      ? voting[kAgree]
                      : voting[kDisagree],
                  context),
              const SizedBox(height: 10),
              _buildBarGraph('تصويت النواب', parlvote, 0.55, 78, context),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBarGraph(String title, String voteResult, double percent,
      int votes, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '$title: ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            Text(
              '$voteResult ($votes)',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: Theme.of(context).colorScheme.surface,
                color: Theme.of(context).colorScheme.primary,
                minHeight: 6,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(percent * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: Column(
        //         children: [
        //           Text(
        //             '${(percent * 100).toStringAsFixed(1)}%',
        //             style: TextStyle(
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.bold,
        //                 color: Theme.of(context).colorScheme.secondary),
        //           ),
        //           const SizedBox(height: 4),
        //           LinearProgressIndicator(
        //             value: percent,
        //             backgroundColor: Colors.grey.shade300,
        //             color: const Color(0xFFD90429),
        //             minHeight: 8,
        //             borderRadius: BorderRadius.circular(8),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }

  // Widget _buildBarGraph(
  //     String voteResult, String parlvote, BuildContext context) {
  //   double extractNumericValue(String input) {
  //     final numericString = input.replaceAll(RegExp(r'[^0-9.]'), '');
  //     return double.tryParse(numericString) ?? 0.0;
  //   }

  //   double voteValue = extractNumericValue(voteResult) / 100;
  //   double parlValue = extractNumericValue(parlvote) / 100;

  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           const Text('المواطنين '),
  //           Expanded(
  //             child: LinearProgressIndicator(
  //               value: voteValue,
  //               backgroundColor: Colors.grey.shade300,
  //               color: const Color(0xFFD90429),
  //             ),
  //           ),
  //           const SizedBox(width: 8),
  //           Text(voteResult),
  //         ],
  //       ),
  //       const SizedBox(height: 8),
  //       Row(
  //         children: [
  //           const Text('النواب '),
  //           Expanded(
  //             child: LinearProgressIndicator(
  //               value: parlValue,
  //               backgroundColor: Colors.grey.shade300,
  //               color: const Color(0xFFD90429),
  //             ),
  //           ),
  //           const SizedBox(width: 8),
  //           Text(parlvote),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildExpandedText(
      String label, String content, BuildContext context) {
    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'IBM Plex Sans Arabic',
        ),
        children: [
          TextSpan(
            text: content,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Theme.of(context).colorScheme.secondary,
              fontFamily: 'IBM Plex Sans Arabic',
            ),
          ),
        ],
      ),
    );
  }
}
