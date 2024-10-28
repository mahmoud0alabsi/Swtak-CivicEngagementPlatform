import 'package:citizens_voice_app/features/parliament/business/entities/parliament_project_entity.dart';

class ParliamentRoundEntity {
  String id;
  int roundNumber;
  DateTime dateOfPost;
  int durationOfAvailability;
  String status;
  List<ParliamentProjectEntity> projects;

  ParliamentRoundEntity({
    required this.id,
    required this.roundNumber,
    required this.dateOfPost,
    required this.durationOfAvailability,
    required this.status,
    required this.projects,
  });

  static ParliamentRoundEntity emptyObj() {
    return ParliamentRoundEntity(
      id: '',
      roundNumber: 0,
      dateOfPost: DateTime.now(),
      durationOfAvailability: 1,
      status: '',
      projects: [],
    );
  }
}
