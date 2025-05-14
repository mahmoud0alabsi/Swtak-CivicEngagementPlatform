import 'package:citizens_voice_app/features/municipality/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:citizens_voice_app/features/parliament/presentation/bloc/ongoing_round/ongoing_round_bloc.dart';
import 'package:citizens_voice_app/theme/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Contributions extends StatelessWidget {
  const Contributions({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(0.0),
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  'assets/icons/parliament.svg',
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      'مجلس النواب',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    BlocBuilder<OngoingProjectsBloc, OngoingProjectsState>(
                      bloc: context.read<OngoingProjectsBloc>(),
                      builder: (context, state) {
                        if (state is OngoingProjectsLoading ||
                            state is OngoingProjectsInitial) {
                          return Skeletonizer(
                            child: Text(
                              'Loading...',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                        int ongoingParlaimentProjectsCount = context
                            .read<OngoingRoundBloc>()
                            .ongoingParliamentRound
                            .projects
                            .length;

                        return Text(
                          ongoingParlaimentProjectsCount == 0
                              ? '6 مشاريع'
                              : ongoingParlaimentProjectsCount == 1
                                  ? 'مشروع واحدة'
                                  : '$ongoingParlaimentProjectsCount مشاريع',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  width: 30,
                ),
                Container(
                  height: 50,
                  width: 1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  children: [
                    Icon(
                      CustomIcons.building,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 24,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        Text(
                          'مجلس البلدية',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        BlocBuilder<OngoingRoundBloc, OngoingRoundState>(
                          bloc: context.read<OngoingRoundBloc>(),
                          builder: (context, state) {
                            if (state is OngoingRoundLoading ||
                                state is OngoingRoundInitial) {
                              return Skeletonizer(
                                child: Text(
                                  'Loading...',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                            int ongoingMunicipalityProjectsCount = context
                                .read<OngoingProjectsBloc>()
                                .ongoingProjects
                                .length;
                            return Text(
                              ongoingMunicipalityProjectsCount == 0
                                  ? 'لا توجد مشاريع'
                                  : ongoingMunicipalityProjectsCount == 1
                                      ? 'مشروع واحد'
                                      : '$ongoingMunicipalityProjectsCount مشاريع',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
