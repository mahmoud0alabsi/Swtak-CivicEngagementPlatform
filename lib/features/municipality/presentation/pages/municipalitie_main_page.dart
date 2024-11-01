import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/archived_projects/archived_projects_bloc.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
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
                            width: 24,
                            height: 26,
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
                      )
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
                fontWeight: FontWeight.w900,
                fontSize: 20,
              ),
              textDirection: TextDirection.rtl,
              overflow: TextOverflow.ellipsis, // Prevents text overflow
            ),
          ),
        ],
      ),
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
              color: _tabController.index == tabIndex
                  ? Theme.of(context).colorScheme.surfaceContainer
                  : Theme.of(context).colorScheme.primary,
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
        return ListView.separated(
            padding: const EdgeInsets.only(bottom: 15.0),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(height: 10),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              return _buildArchiveCard(
                  projects[index], Icons.school_outlined);
            });
      },
    );
    // return ListView(
    //   children: [
    //     _buildArchiveCard(
    //         1,
    //         'تعديل قانون التعليم العام',
    //         'اقتراح لزيادة مخصصات التعليم وتحسين البنية التحتية للمدارس في المناطق النائية.',
    //         'الإثنين 16-09-2024',
    //         '60% لا أوافق',
    //         'لا أوافق',
    //         Icons.school_outlined),
    //     // _buildArchiveCard(
    //     //     2,
    //     //     'قانون دعم رواد الأعمال والشركات الناشئة',
    //     //     'اقتراح لتقديم دعم مالي للشركات الناشئة وتخفيف الضرائب لمدة 5 سنوات.',
    //     //     'الثلاثاء 17-09-2024',
    //     //     '77% أوافق',
    //     //     'أوافق',
    //     //     Icons.business_center_outlined),
    //     // _buildArchiveCard(
    //     //     3,
    //     //     'مشروع قانون تنظيم التجارة الإلكترونية',
    //     //     'اقتراح لوضع قوانين جديدة تضمن حقوق المستهلكين وتعزيز الأمن الإلكتروني.',
    //     //     'الأربعاء 18-09-2024',
    //     //     '54% أوافق',
    //     //     'لا أوافق',
    //     //     Icons.local_gas_station_outlined),
    //     // _buildArchiveCard(
    //     //     4,
    //     //     'تعديل قانون التعليم العام',
    //     //     'اقتراح لزيادة مخصصات التعليم وتحسين البنية التحتية للمدارس في المناطق النائية.',
    //     //     'الإثنين 16-09-2024',
    //     //     '60% أوافق',
    //     //     ' اوافق',
    //     //     Icons.school_outlined),
    //     // _buildArchiveCard(
    //     //     5,
    //     //     'قانون دعم رواد الأعمال والشركات الناشئة',
    //     //     'اقتراح لتقديم دعم مالي للشركات الناشئة وتخفيف الضرائب لمدة 5 سنوات.',
    //     //     'الثلاثاء 17-09-2024',
    //     //     '93% أوافق',
    //     //     ' اوافق',
    //     //     Icons.park_outlined),
    //     // _buildArchiveCard(
    //     //     6,
    //     //     'مشروع قانون تنظيم التجارة الإلكترونية',
    //     //     'اقتراح لوضع قوانين جديدة تضمن حقوق المستهلكين وتعزيز الأمن الإلكتروني.',
    //     //     'الأربعاء 18-09-2024',
    //     //     '52% أوافق',
    //     //     'لا اوافق',
    //     //     Icons.local_airport_outlined)

    //   ],
    // );
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
                  _getRemainingTimeText(
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
                    child: Icon(
                      icon,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40,
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

// Helper method to format remaining time as a string
  String _getRemainingTimeText(Duration remainingTime) {
    if (remainingTime.inDays > 2 && remainingTime.inDays < 11) {
      return 'متبقي ${remainingTime.inDays} أيام';
    } else if (remainingTime.inDays >= 11) {
      return 'متبقي ${remainingTime.inDays} يوم';
    } else if (remainingTime.inDays == 2) {
      return 'متبقي يومان';
    } else if (remainingTime.inDays == 1) {
      return 'متبقي يوم واحد';
    } else if (remainingTime.inHours > 1) {
      return '${remainingTime.inHours} ساعة';
    } else if (remainingTime.inHours == 1) {
      return 'ساعة واحدة';
    } else if (remainingTime.inMinutes > 1) {
      return '${remainingTime.inMinutes} دقيقة';
    } else if (remainingTime.inMinutes == 1) {
      return 'دقيقة واحدة';
    } else {
      return 'انتهت المدة';
    }
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
        margin: const EdgeInsets.only(bottom: 15),
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
                Icon(icon,
                    color: Theme.of(context).colorScheme.primary, size: 45),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'مشروع رقم ${project.projectNumber}',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
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
              _buildExpandedText('تفاصيل التصويت: ', project.details, context),
              const SizedBox(height: 9),
              _buildExpandedText(
                  'التاريخ: ', project.dateOfPost.toString(), context),
              const SizedBox(height: 9),
              _buildExpandedText('نتيجة تصويتك: ', project.userVote, context),
              const SizedBox(height: 9),
              _buildBarGraph('', context),
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
    return Directionality(
      textDirection: TextDirection.rtl,
      child: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Theme.of(context).colorScheme.secondary,
          ),
          children: [
            TextSpan(
              text: content,
              style: const TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }

  // Method to display a simple bar graph
  Widget _buildBarGraph(String voteResult, BuildContext context) {
    double extractNumericValue(String input) {
      final numericString = input.replaceAll(RegExp(r'[^0-9.]'), '');
      return double.tryParse(numericString) ?? 0.0;
    }

    double voteValue = extractNumericValue(voteResult) / 100;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('تصويت المواطنين: ',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary)),
            Expanded(
              child: LinearProgressIndicator(
                value: voteValue,
                backgroundColor: Colors.grey.shade300,
                color: const Color(0xFFD90429),
              ),
            ),
            const SizedBox(width: 8),
            Text(voteResult), // Display percentage as is
          ],
        ),
        const SizedBox(height: 8),
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
