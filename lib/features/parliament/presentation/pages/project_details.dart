import 'package:citizens_voice_app/features/parliament/business/entities/parliament_project_entity.dart';
import 'package:citizens_voice_app/features/parliament/const.dart';
import 'package:citizens_voice_app/features/parliament/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:citizens_voice_app/features/parliament/presentation/widgets/confirm_voting_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProjectDetailsPage extends StatefulWidget {
  final OngoingProjectsBloc bloc;
  final ParliamentProjectEntity project;
  const ProjectDetailsPage(
      {super.key, required this.bloc, required this.project});

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late OngoingProjectsBloc _bloc;
  late ParliamentProjectEntity _project;

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
          }
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
                        _project.responsibleInstitution,
                        _project.details),
                    const SizedBox(height: 15),

                    // If the user has already voted, show a different card
                    if (_bloc.ongoingParliamentRound.projects
                            .firstWhere((element) => element.id == _project.id)
                            .userVote !=
                        '')
                      _buildVotingDoneCard(context)
                    else
                      _buildVotingOptions(context),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            if (state is VoteOnProjectLoading)
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
        'مجلس النواب',
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

  Widget _buildInfoCard(BuildContext context, String title, String number,
      String responsibleInstitution, String details) {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildInfoText(context, "الرقم: $number", TextAlign.start),
                  const Spacer(),
                  _buildInfoText(
                      context, responsibleInstitution, TextAlign.end),
                  // const Spacer(),
                  // _buildInfoText(context, dataOfPost),
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 236, 233, 233),
              thickness: 1,
            ),
            Text(
              details.replaceAll('\\n', '\n'),
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
                height: 1.5,
              ),
              textAlign: TextAlign.start,
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
          children: [
            Text(
              "اختر الخيار المناسب أدناه للتعبير عن رأيك ومشاركتك موقفك حول هذه القضية:",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 10,
                fontWeight: FontWeight.w500,
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
                      decoration: TextDecoration.underline,
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
              if (_project.userVote.isNotEmpty) ...[
                _buildExpandedText(
                    'نتيجة تصويتك: ',
                    _project.userVote == kAgree ? kAgreeAr : kDisagreeAr,
                    context),
                const SizedBox(height: 10),
              ],
              _buildBarGraph(
                  'تصويت المواطنين',
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
              const SizedBox(height: 10),
              _buildBarGraph('تصويت النواب', 'أوافق', 0.74, 70, context),
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
              fontWeight: FontWeight.bold,
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
