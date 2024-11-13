import 'package:citizens_voice_app/core/fields_map.dart';
import 'package:citizens_voice_app/features/parliament/business/entities/parliament_project_entity.dart';
import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';
import 'package:citizens_voice_app/features/parliament/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'project_details.dart';

class ParliamentOngoingRoundPage extends StatefulWidget {
  final ParliamentRoundEntity ongoingRound;
  const ParliamentOngoingRoundPage({super.key, required this.ongoingRound});

  @override
  State<ParliamentOngoingRoundPage> createState() =>
      _ParliamentOngoingRoundPageState();
}

class _ParliamentOngoingRoundPageState
    extends State<ParliamentOngoingRoundPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OngoingProjectsBloc(
        parliamentRoundEntity: widget.ongoingRound,
      ),
      lazy: false,
      child: BlocConsumer<OngoingProjectsBloc, OngoingProjectsState>(
        listener: (context, state) {},
        builder: (context, state) {
          OngoingProjectsBloc ongoingProjectsBloc =
              context.read<OngoingProjectsBloc>();
          List<ParliamentProjectEntity> projects = context
              .read<OngoingProjectsBloc>()
              .ongoingParliamentRound
              .projects;

          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
              titleSpacing: 0,
              title: Text(
                'مجلس النواب',
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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                  children: [
                    // "صوت الآن" card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/vote_now.svg',
                                width: 20,
                                height: 22,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'صوِّت الآن',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'تصفح المشاريع التي يناقشها مجلس النواب حالياً، يمكنك اختيار أي منها للتصويت والمشاركة في اتخاذ القرار.',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => OngoingProjectsBloc(
                                    parliamentRoundEntity: widget.ongoingRound,
                                  ),
                                  child: ProjectDetailsPage(
                                    bloc: ongoingProjectsBloc,
                                    project: projects[index],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: IssueCard(
                            issueNumber: projects[index].projectNumber,
                            title: projects[index].title,
                            type: projects[index].type,
                            tags: projects[index].tags,
                            icon: Icons.school_outlined,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class IssueCard extends StatelessWidget {
  final int issueNumber;
  final String title;
  final String type;
  final List<String> tags;
  final IconData icon;

  const IssueCard({
    super.key,
    required this.issueNumber,
    required this.title,
    required this.type,
    required this.tags,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: SvgPicture.asset(
                getProjectTypeIcon(type),
                height: 34,
                width: 34,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'مشروع رقم $issueNumber',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 9),
                // Pass context to buildTag
                Wrap(
                  spacing: 5,
                  children: tags.map((tag) => buildTag(tag, context)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Function to create a tag widget (unchanged)
  Widget buildTag(String tag, BuildContext context) {
    return Container(
      width: 36,
      height: 18,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainer, // Background color stays white
        border: Border.all(
            color: Theme.of(context).colorScheme.primary, width: 1.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          tag,
          style: TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.w600,
            color:
                Theme.of(context).colorScheme.primary, // Text color now dynamic
          ),
        ),
      ),
    );
  }
}
