import 'dart:async';

import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/const.dart';

class MunicipalityProjectModel extends MunicipalityProjectEntity {
  MunicipalityProjectModel({
    required super.id,
    required super.title,
    required super.details,
    required super.dateOfPost,
    required super.durationOfAvailability,
    required super.type,
    required super.tags,
    required super.voting,
    required super.projectNumber,
    required super.isFinished,
  }){
    super.dateOfEnd = dateOfPost.add(Duration(days: durationOfAvailability));
  }

  factory MunicipalityProjectModel.fromJson(
      String id, Map<String, dynamic> json) {
    return MunicipalityProjectModel(
      id: id,
      title: json[kTitle],
      details: json[kDetails],
      dateOfPost: json[kDateOfPost].toDate(),
      durationOfAvailability: json[kDurationOfAvailability],
      type: json[kType],
      tags: List<String>.from(json[kTags]),
      voting: json[kVoting],
      isFinished: json[kIsFinished],
      projectNumber: json[kProjectNumber],
    );
  }

  static FutureOr<List<MunicipalityProjectModel>>? emptyObj() {
    return [];
  }
}
