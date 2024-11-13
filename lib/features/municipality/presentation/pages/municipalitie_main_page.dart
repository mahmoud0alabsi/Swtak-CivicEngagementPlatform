import 'package:citizens_voice_app/core/date_formatter.dart';
import 'package:citizens_voice_app/core/fields_map.dart';
import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/const.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/archived_projects/archived_projects_bloc.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:citizens_voice_app/features/municipality/presentation/pages/munstat.dart';
import 'package:citizens_voice_app/features/shared/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'project_details.dart';

class MunicipalityMainPage extends StatefulWidget {
  const MunicipalityMainPage({super.key});

  @override
  MunicipalityMainPageState createState() => MunicipalityMainPageState();
}

class MunicipalityMainPageState extends State<MunicipalityMainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _expandedCardIndex = -1; // To track the expanded card

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: appBar(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Card(
                shadowColor: Colors.transparent,
                color: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(0),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/handshake.svg',
                            width: 22,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            'كن فاعلًا في بلديتك',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'شارك الآن في التصويت على القرارات والقوانين التي تُناقش في مجلس البدلية. صوتك سيساهم في توجيه أصحاب القرار نحو اتخاذ خيارات تعكس آراء المواطنين.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Theme.of(context).colorScheme.primary,
                            size: 18,
                          ),
                          const SizedBox(width: 3),
                          Flexible(
                            child: Text(
                              'الزرقاء - الرصيفة - بلدية الرصيفة',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.secondary,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double screenWidth = MediaQuery.of(context).size.width;
                  double buttonWidth = (screenWidth - 32 - 10) /
                      2; // Dynamically calculate width
                  buttonWidth =
                      buttonWidth > 180 ? 180 : buttonWidth; // Set max width

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: _buildTabButton(
                              context,
                              'المشاريع المطروحة',
                              0,
                              'assets/icons/fire.svg',
                              buttonWidth,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                    0,
                                    2,
                                  ),
                                ),
                              ],
                            ),
                            child: _buildTabButton(
                              context,
                              'الأرشيف',
                              1,
                              'assets/icons/reload.svg',
                              buttonWidth,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: _buildProjectsTab(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: _buildArchiveTab(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'مجلس البلدية',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis, // Prevents text overflow
            ),
          ),
        ],
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
                      const MunicipalityVotingStatisticsPage(),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  // Build Tab Button
  Widget _buildTabButton(BuildContext context, String label, int tabIndex,
      String svgPath, double buttonWidth) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.animateTo(tabIndex,
              duration: const Duration(milliseconds: 200));
        });
      },
      child: Container(
        width: buttonWidth, // Dynamic width
        height: 50,
        decoration: BoxDecoration(
          color: _tabController.index == tabIndex
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(
                _tabController.index == tabIndex
                    ? Theme.of(context).colorScheme.surfaceContainer
                    : Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
              height: 22,
              width: 22,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: _tabController.index == tabIndex
                    ? Theme.of(context).colorScheme.surfaceContainer
                    : Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Issues Tab (First Tab)
  Widget _buildProjectsTab(BuildContext context) {
    return BlocConsumer<OngoingProjectsBloc, OngoingProjectsState>(
      listener: (context, state) {
        if (state is OngoingProjectsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is OngoingProjectsLoading ||
            state is OngoingProjectsInitial) {
          return const LoadingSpinner();
        }
        List<MunicipalityProjectEntity> projects =
            context.read<OngoingProjectsBloc>().ongoingProjects;
        return ListView.separated(
            padding: const EdgeInsets.only(bottom: 15.0),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return _buildProjectsCard(context.read<OngoingProjectsBloc>(),
                  projects[index], Icons.school_outlined);
            });
      },
    );
  }

  // Build Archive Tab (Second Tab) with expandable cards
  Widget _buildArchiveTab(BuildContext context) {
    return BlocConsumer<ArchivedProjectsBloc, ArchivedProjectsState>(
      listener: (context, state) {
        if (state is ArchivedProjectsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ArchivedProjectsLoading ||
            state is ArchivedProjectsInitial) {
          return const LoadingSpinner();
        }
        List<MunicipalityProjectEntity> projects =
            context.read<ArchivedProjectsBloc>().archivedProjects;
        projects.sort((a, b) => b.projectNumber.compareTo(a.projectNumber));
        return ListView.separated(
            padding: const EdgeInsets.only(bottom: 15.0),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return _buildArchiveCard(projects[index], Icons.school_outlined);
            });
      },
    );
  }

  // Issue Card for TabBarView (clickable)
  Widget _buildProjectsCard(OngoingProjectsBloc bloc,
      MunicipalityProjectEntity project, IconData icon) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => OngoingProjectsBloc(),
              child: ProjectDetailsPage(
                bloc: bloc,
                project: project,
              ),
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  getRemainingTimeText(
                    project.dateOfEnd.difference(DateTime.now()),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    fontSize: 7,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
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
                      getProjectTypeIcon(project.type),
                      height: 36,
                      width: 36,
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
                    children: [
                      Text(
                        'مشروع رقم ${project.projectNumber}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        project.title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 9,
                      ),
                      Wrap(
                        spacing: 5,
                        children:
                            project.tags.map((tag) => _buildTag(tag)).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Archive Card with expandable details
  Widget _buildArchiveCard(MunicipalityProjectEntity project, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _expandedCardIndex = _expandedCardIndex == project.projectNumber
              ? -1
              : project.projectNumber;
        });
      },
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
                  getProjectTypeIcon(project.type),
                  height: 34,
                  width: 34,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'مشروع رقم ${project.projectNumber}',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        project.title,
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
            if (_expandedCardIndex == project.projectNumber) ...[
              const SizedBox(height: 10),
              _buildExpandedText('تفاصيل المشروع: ', project.details, context),
              const SizedBox(height: 9),
              _buildExpandedText('التاريخ: ',
                  getDateFormattedWithYear(project.dateOfPost), context),
              const SizedBox(height: 9),
              if (project.userVote.isNotEmpty) ...[
                _buildExpandedText('نتيجة تصويتك: ', project.userVote, context),
                const SizedBox(height: 9),
              ],
              _buildBarGraph(
                  project.voting[kAgree] >= project.voting[kDisagree]
                      ? kAgreeAr
                      : kDisagreeAr,
                  project.voting[kAgree] >= project.voting[kDisagree]
                      ? project.voting[kAgree] /
                          (project.voting[kAgree] + project.voting[kDisagree])
                      : project.voting[kDisagree] /
                          (project.voting[kAgree] + project.voting[kDisagree]),
                  project.voting[kAgree] >= project.voting[kDisagree]
                      ? project.voting[kAgree]
                      : project.voting[kDisagree],
                  context),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  // Method to display expanded text
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
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: 'IBM Plex Sans Arabic',
            ),
          ),
        ],
      ),
    );
  }

  // Method to display a simple bar graph
  Widget _buildBarGraph(
      String voteResult, double percent, int votes, BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'تصويت المواطنين: ',
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
      ],
    );
  }

  // Tag Widget
  Widget _buildTag(String tag) {
    return Container(
      width: 32,
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
    // return Container(
    //   width: 40,
    //   height: 21,
    //   decoration: BoxDecoration(
    //     color: Theme.of(context).colorScheme.surfaceContainer,
    //     border: Border.all(
    //         color: Theme.of(context).colorScheme.primary, width: 1.3),
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child: Center(
    //     child: Text(
    //       tag,
    //       style: TextStyle(
    //         fontSize: 9,
    //         color: Theme.of(context).colorScheme.primary,
    //       ),
    //     ),
    //   ),
    // );
  }
}
