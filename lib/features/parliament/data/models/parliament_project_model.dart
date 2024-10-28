import 'package:citizens_voice_app/features/parliament/business/entities/parliament_project_entity.dart';
import 'package:citizens_voice_app/features/parliament/const.dart';

class ParliamentProjectModel extends ParliamentProjectEntity {
  ParliamentProjectModel({
    required super.id,
    required super.title,
    required super.details,
    required super.projectNumber,
    required super.type,
    required super.tags,
    required super.responsibleInstitution,
    required super.voting,
  });

  factory ParliamentProjectModel.fromJson(
      String id, Map<String, dynamic> json) {
    return ParliamentProjectModel(
      id: id,
      title: json[kTitle],
      details: json[kDetails],
      projectNumber: json[kProjectNumber],
      type: json[kType],
      tags: List<String>.from(json[kTags]),
      responsibleInstitution: json[kResponsibleInstitution],
      voting: json[kVoting],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kTitle: title,
      kDetails: details,
      kProjectNumber: projectNumber,
      kType: type,
      kTags: tags,
      kResponsibleInstitution: responsibleInstitution,
      kVoting: voting,
    };
  }
}
