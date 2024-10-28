import 'dart:async';

import 'package:citizens_voice_app/features/parliament/business/entities/parliament_project_entity.dart';
import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';
import 'package:citizens_voice_app/features/parliament/const.dart';

class ParliamentRoundModel extends ParliamentRoundEntity {
  ParliamentRoundModel({
    required super.id,
    required super.roundNumber,
    required super.dateOfPost,
    required super.durationOfAvailability,
    required super.status,
    required super.projects,
  });

  factory ParliamentRoundModel.fromJson(String id, Map<String, dynamic> json,
      [List<ParliamentProjectEntity>? projects]) {
    return ParliamentRoundModel(
      id: id,
      roundNumber: json[kRoundNumber],
      dateOfPost: json[kDateOfPost].toDate(),
      durationOfAvailability: json[kDurationOfAvailability],
      status: json[kStatus],
      projects: projects ?? [],
    );
  }

  static FutureOr<ParliamentRoundModel>? emptyObj() {
    return ParliamentRoundModel(
      id: '',
      roundNumber: 0,
      dateOfPost: DateTime.now(),
      durationOfAvailability: 0,
      status: '',
      projects: [],
    );
  }
}
