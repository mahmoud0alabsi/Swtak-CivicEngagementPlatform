import 'package:citizens_voice_app/core/date_formatter.dart';
import 'package:citizens_voice_app/core/fields_map.dart';
import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:citizens_voice_app/features/municipality/presentation/pages/project_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class CarousalItem extends StatelessWidget {
  final MunicipalityProjectEntity project;
  const CarousalItem({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        OngoingProjectsBloc bloc = context.read<OngoingProjectsBloc>();
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
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildRemainingDurationCard(context),
            const SizedBox(height: 12),
            Expanded(child: _buildMainContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildRemainingDurationCard(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          color: Theme.of(context).colorScheme.surfaceContainer,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(15), topLeft: Radius.circular(15)),
          ),
          margin: const EdgeInsets.all(0.0),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Text(
              getRemainingTimeText(
                project.dateOfEnd.difference(DateTime.now()),
              ),
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Builds the main content with the icon and additional info
  Widget _buildMainContent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(flex: 1, child: _buildIconCard(context)),
        const SizedBox(width: 12),
        Expanded(flex: 2, child: _buildInfoColumn(context)),
      ],
    );
  }

  // Builds the icon section
  Widget _buildIconCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: SizedBox(
        height: 75.1,
        width: 75.1,
        child: Card(
          color: Theme.of(context).colorScheme.primary,
          child: Center(
              child: SvgPicture.asset(
            getProjectTypeIcon(project.type),
            height: 42,
            width: 42,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.surfaceContainer,
              BlendMode.srcIn,
            ),
          )),
        ),
      ),
    );
  }

  // Builds the information column with title and date
  Widget _buildInfoColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: _buildDateContainer(context)),
            const Spacer(),
            Flexible(child: _buildCaseNumberCard(context)),
          ],
        ),
      ],
    );
  }

  // Builds the date section in a container
  Widget _buildDateContainer(BuildContext context) {
    return Container(
      height: 42,
      width: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.secondary,
      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 4.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getDayNameInArabic(project.dateOfEnd),
              style: TextStyle(
                color: Theme.of(context).colorScheme.surfaceContainer,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              getSuggestionDateFormatted(project.dateOfEnd),
              style: TextStyle(
                color: Theme.of(context).colorScheme.surfaceContainer,
                fontWeight: FontWeight.w700,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Builds the case number section
  Widget _buildCaseNumberCard(BuildContext context) {
    return Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Center(
          child: Text(
            "رقم المشروع\n${project.projectNumber}",
            style: TextStyle(
              color: Theme.of(context).colorScheme.surfaceContainer,
              fontSize: 9,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
