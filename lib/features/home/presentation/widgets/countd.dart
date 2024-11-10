import 'package:citizens_voice_app/features/parliament/presentation/bloc/ongoing_round/ongoing_round_bloc.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slide_countdown/slide_countdown.dart';

class Count1 extends StatefulWidget {
  final BuildContext context;
  const Count1({super.key, required this.context});

  @override
  State<Count1> createState() => _CountState();
}

class _CountState extends State<Count1> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1.0,
      margin: const EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
        child: BlocBuilder<OngoingRoundBloc, OngoingRoundState>(
          bloc: context.read<OngoingRoundBloc>(),
          builder: (context, state) {
            if (state is OngoingRoundLoading || state is OngoingRoundInitial) {
              return const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 32,
                ),
                child: LoadingSpinner(),
              );
            }
            Duration duration = context
                .read<OngoingRoundBloc>()
                .ongoingParliamentRound
                .dateOfPost
                .add(Duration(
                  days: context
                      .read<OngoingRoundBloc>()
                      .ongoingParliamentRound
                      .durationOfAvailability,
                ))
                .difference(DateTime.now());
            return Center(
              child: duration.inSeconds <= 0
                  ? Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.timer_off_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 35,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            'انتهى الوقت المتاح للتصويت، سيتم نشر جولة تصويت جديدة قريباً',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'شارك الآن في التصويت على القضايا المطروحة من قبل مجلس البرلمان',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: SlideCountdownSeparated(
                            duration: duration,
                            countUp: false,
                            separatorStyle: TextStyle(
                              fontSize: 25,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surfaceContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            durationTitle: DurationTitle.ar(),
                            separatorPadding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ثانية',
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              const SizedBox(width: 42),
                              Text('دقيقة',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              const SizedBox(width: 42),
                              Text('ساعة',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              const SizedBox(width: 46),
                              Text(' يوم',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
