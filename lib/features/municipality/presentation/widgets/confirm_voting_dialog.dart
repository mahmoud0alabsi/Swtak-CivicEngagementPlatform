import 'package:citizens_voice_app/features/municipality/presentation/bloc/ongoing_projects/ongoing_projects_bloc.dart';
import 'package:flutter/material.dart';

void showConfirmationDialog(BuildContext context, String voteOption,
    OngoingProjectsBloc bloc, String projectId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog.adaptive(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          "تأكيد التصويت",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "هل أنت متأكد من تصويتك بـ ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  TextSpan(
                    text: voteOption,
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: "؟",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "تنويه",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  TextSpan(
                    text: ": ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text:
                        "لن تتمكن من تغيير أو تعديل تصويتك بعد إرساله، يرجى التأكد من اختيارك قبل المتابعة.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actionsPadding: const EdgeInsets.only(
          left: 10,
          right: 10,
          bottom: 20,
        ),
        actions: [
          _buildDialogButton(
            context,
            "إلغاء",
            Theme.of(context).colorScheme.secondary,
            () => Navigator.of(context).pop(),
          ),
          _buildDialogButton(
            context,
            "تأكيد",
            Theme.of(context).colorScheme.primary,
            () {
              bloc.add(
                VoteForProject(projectId, voteOption, context),
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Widget _buildDialogButton(
    BuildContext context, String label, Color color, Function()? onPressed) {
  return SizedBox(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(100, 40),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).colorScheme.surfaceContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
