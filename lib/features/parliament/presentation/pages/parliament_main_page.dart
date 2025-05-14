import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';
import 'package:citizens_voice_app/features/parliament/presentation/bloc/ongoing_round/ongoing_round_bloc.dart';
import 'package:citizens_voice_app/features/parliament/presentation/pages/parlstat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/main_header.dart';
import 'archive_page.dart';
import '../widgets/buttons.dart';
import '../widgets/countd.dart';
import 'ongoing_round_page.dart';

class ParliamentMainPage extends StatefulWidget {
  const ParliamentMainPage({super.key});

  @override
  State<ParliamentMainPage> createState() => _ParliamentMainPageState();
}

class _ParliamentMainPageState extends State<ParliamentMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مجلس النواب',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          SizedBox(
            width: 40,
            height: 40,
            child: IconButton(
              icon: Icon(
                Icons.bar_chart_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ParliamentVotingStatisticsPage(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BlocConsumer<OngoingRoundBloc, OngoingRoundState>(
        listener: (context, state) {
          if (state is OngoingRoundError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is OngoingRoundLoading || state is OngoingRoundInitial) {
            return Skeletonizer(
              enabled: true,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const MainHeaderWidget(),
                      const SizedBox(height: 15),
                      CountdownWidget(
                        dateOfPost: DateTime.now(),
                        daysOfAvailability: 1,
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 130,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: const VoteButton(
                                  svgAssetPath: 'assets/icons/newvote.svg',
                                  label: "صوت الآن",
                                  backgroundColors: [
                                    Color(0xFFFF3558),
                                    Color(0xFFD90429),
                                    Color(0xFFB00016),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 22),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ParliamentArchivePage(),
                                    ),
                                  );
                                },
                                child: const VoteButton(
                                  svgAssetPath: 'assets/icons/reload.svg',
                                  label: "الأرشيف",
                                  backgroundColors: [
                                    Color(0xFA5C6378),
                                    Color(0xFF383B50),
                                    Color(0xFF2B2D42),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'تنويه',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'IBM Plex Sans Arabic',
                              ),
                            ),
                            TextSpan(
                              text: ': ',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'IBM Plex Sans Arabic',
                              ),
                            ),
                            TextSpan(
                              text:
                                  'كل مشروع يتم طرحه للنقاش يؤثر على حياتنا اليومية، ومن خلال هذا التطبيق، '
                                  'يمكنك أن تكون جزءًا من هذه العملية، قم بقراءة المعلومات المتاحة عن المشاريع المطروحة، ثم '
                                  'استخدم حقك في التصويت لتقديم وجهة نظرك حولها.',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'IBM Plex Sans Arabic',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          ParliamentRoundEntity ongoingRound =
              context.read<OngoingRoundBloc>().ongoingParliamentRound;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const MainHeaderWidget(),
                  const SizedBox(height: 15),
                  CountdownWidget(
                    dateOfPost: context
                        .read<OngoingRoundBloc>()
                        .ongoingParliamentRound
                        .dateOfPost,
                    daysOfAvailability: context
                        .read<OngoingRoundBloc>()
                        .ongoingParliamentRound
                        .durationOfAvailability,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 130,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ParliamentOngoingRoundPage(
                                    ongoingRound: ongoingRound,
                                  ),
                                ),
                              );
                            },
                            child: const VoteButton(
                              svgAssetPath: 'assets/icons/newvote.svg',
                              label: "صوت الآن",
                              backgroundColors: [
                                Color(0xFFFF3558),
                                Color(0xFFD90429),
                                Color(0xFFB00016),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 22),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ParliamentArchivePage(),
                                ),
                              );
                            },
                            child: const VoteButton(
                              svgAssetPath: 'assets/icons/reload.svg',
                              label: "الأرشيف",
                              backgroundColors: [
                                Color(0xFA5C6378),
                                Color(0xFF383B50),
                                Color(0xFF2B2D42),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'تنويه',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IBM Plex Sans Arabic',
                          ),
                        ),
                        TextSpan(
                          text: ': ',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'IBM Plex Sans Arabic',
                          ),
                        ),
                        TextSpan(
                          text:
                              'كل مشروع يتم طرحه للنقاش يؤثر على حياتنا اليومية، ومن خلال هذا التطبيق، '
                              'يمكنك أن تكون جزءًا من هذه العملية، قم بقراءة المعلومات المتاحة عن المشاريع المطروحة، ثم '
                              'استخدم حقك في التصويت لتقديم وجهة نظرك حولها.',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'IBM Plex Sans Arabic',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
