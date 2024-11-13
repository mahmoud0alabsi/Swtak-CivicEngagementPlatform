import 'package:citizens_voice_app/core/date_formatter.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/const.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:citizens_voice_app/features/municipality/presentation/widgets/confirm_voting_dialog.dart';
import 'package:citizens_voice_app/features/municipality/presentation/widgets/submitDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectDetailsPage extends StatefulWidget {
  final OngoingProjectsBloc bloc;
  final MunicipalityProjectEntity project;
  const ProjectDetailsPage(
      {super.key, required this.bloc, required this.project});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  final TextEditingController _commentController = TextEditingController();
  late OngoingProjectsBloc _bloc;
  late MunicipalityProjectEntity _project;

  @override
  void initState() {
    super.initState();
    _bloc = widget.bloc;
    _project = widget.project;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: BlocConsumer<OngoingProjectsBloc, OngoingProjectsState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is VoteOnProjectDone) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AddCommentToProjectDone) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is OngoingProjectsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildInfoCard(
                      context,
                      _project.title,
                      _project.projectNumber.toString(),
                      _project.details,
                    ),
                    const SizedBox(height: 15),

                    // If the user has already voted, show a different card
                    if (_bloc.ongoingProjects
                            .firstWhere((element) => element.id == _project.id)
                            .userVote !=
                        '')
                      _buildVotingDoneCard(context)
                    else
                      _buildVotingOptions(context),
                    const SizedBox(height: 15),

                    _buildcomment(context),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            if (state is VoteOnProjectLoading ||
                state is AddCommentToProjectLoading)
              Container(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
          ]);
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Text(
        'مجلس البلدية',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textDirection: TextDirection.rtl,
      ),
      elevation: 0,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.primary),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_outlined),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, String title, String number, String details) {
    return Card(
      shadowColor: Colors.transparent,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildInfoText(context, "الرقم: ${_project.projectNumber}",
                      TextAlign.start),
                  const Spacer(),
                  _buildInfoText(
                      context,
                      getSuggestionDateFormatted(_project.dateOfPost),
                      TextAlign.end),
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 236, 233, 233),
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8,
                left: 8,
                right: 8,
              ),
              child: Text(
                details.replaceAll('\\n', '\n'),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 14,
                  height: 1.5,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoText(
      BuildContext context, String text, TextAlign textAlign) {
    // Calculate the font size based on screen width
    double screenWidth = MediaQuery.of(context).size.width;
    double dynamicFontSize =
        screenWidth * 0.025; // Adjust the multiplier as necessary

    return Expanded(
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: dynamicFontSize.clamp(
              7.0, 9.0), // Clamp to a minimum and maximum size
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildVotingOptions(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(0),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "اختر الخيار المناسب أدناه للتعبير عن رأيك ومشاركتك موقفك حول هذه القضية:",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildVoteButton(
                    context,
                    "أوافق",
                    'assets/icons/up_thumbs_like_icon.svg',
                    Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 20),
                  _buildVoteButton(
                    context,
                    "لا أوافق",
                    'assets/icons/thumbs_down_icon.svg',
                    Theme.of(context).colorScheme.secondary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
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
                        'يمكنك التصويت مرة واحدة فقط، ولن تتمكن من تغيير أو تعديل تصويتك بعد إرساله. يرجى التأكد من اختيارك قبل المتابعة',
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
  }

  Widget _buildVotingDoneCard(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shadowColor: Colors.transparent,
        color: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "لقد قمت بالتصويت بالفعل على هذا المشروع",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'تصويتك: ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IBM Plex Sans Arabic',
                      ),
                    ),
                    TextSpan(
                      text:
                          _project.userVote == kAgree ? kAgreeAr : kDisagreeAr,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IBM Plex Sans Arabic',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Text(
              //   'المواطنين: ${_project.voting[kAgree]} موافقين، ${_project.voting[kDisagree]} غير موافقين',
              // ),
              _buildBarGraph(
                  _project.voting[kAgree] >= _project.voting[kDisagree]
                      ? kAgreeAr
                      : kDisagreeAr,
                  _project.voting[kAgree] >= _project.voting[kDisagree]
                      ? _project.voting[kAgree] /
                          (_project.voting[kAgree] + _project.voting[kDisagree])
                      : _project.voting[kDisagree] /
                          (_project.voting[kAgree] +
                              _project.voting[kDisagree]),
                  _project.voting[kAgree] >= _project.voting[kDisagree]
                      ? _project.voting[kAgree]
                      : _project.voting[kDisagree],
                  context),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVoteButton(
      BuildContext context, String label, String svgPath, Color color) {
    return Expanded(
      child: SizedBox(
        height: 90,
        child: ElevatedButton(
          onPressed: () {
            showConfirmationDialog(context, label, _bloc, _project.id);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: SvgPicture.asset(
                  svgPath,
                  height: 18,
                  width: 18,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildcomment(BuildContext context) {
    return BlocBuilder<UserManagerBloc, UserManagerState>(
      bloc: context.read<UserManagerBloc>(),
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Card(
            shadowColor: Colors.transparent,
            color: Theme.of(context).colorScheme.surfaceContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: context
                      .read<UserManagerBloc>()
                      .user
                      .municipalityProjectsCommented
                      .containsKey(_project.id)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "لقد قمت بالتعليق بالفعل على هذا المشروع، التعليق الخاص بك:",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          context
                              .read<UserManagerBloc>()
                              .user
                              .municipalityProjectsCommented[_project.id]!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "يمكنك كتابة تعليق وإرساله للجهة المعنية في حال كان لديك مقترح حول هذ المشروع:",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surface, // The background color of the TextField container
                            borderRadius:
                                BorderRadius.circular(8), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.2), // Shadow color
                                spreadRadius: 1, // Spread radius of the shadow
                                blurRadius: 1, // Blur effect of the shadow
                                offset: const Offset(
                                    0, 0), // Offset to position the shadow
                              ),
                            ],
                          ),
                          child: TextField(
                            maxLines: 4,
                            maxLength: 200,
                            controller: _commentController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none,
                              ),
                              hintText: "قم بكتابة تعليق جديد...",
                              hintStyle: const TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'تنويه: ',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'IBM Plex Sans Arabic',
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          'يتم إرسال التعليق الخاص الى الجهة المعنية فقط، ولا يتم مشاركته مع المستخدمين الآخرين.',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'IBM Plex Sans Arabic',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            IconButton(
                              icon: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()..rotateY(3.14159),
                                child: SvgPicture.asset(
                                  'assets/icons/post.svg',
                                  colorFilter: ColorFilter.mode(
                                    Theme.of(context).colorScheme.primary,
                                    BlendMode.srcIn,
                                  ),
                                  width: 24,
                                  height: 24,
                                ),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                              onPressed: () {
                                if (_commentController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text("الرجاء كتابة تعليق"),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                  return;
                                }
                                submitDialog(
                                  context,
                                  _project.id,
                                  _commentController.text,
                                  _bloc,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
    // Comment section ends here
  }

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
}
