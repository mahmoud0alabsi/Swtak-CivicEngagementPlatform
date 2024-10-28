import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';

abstract class IMunicipalityProjectsRepository {
  Future<List<MunicipalityProjectEntity>> getOngoingProjects();
  Future<List<MunicipalityProjectEntity>> getArchivedProjects();

  Future<void> voteForProject(String projectId, String vote);
}
