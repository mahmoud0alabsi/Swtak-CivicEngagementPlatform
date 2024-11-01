import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/business/repositories/municipality_projects_repository.dart';
import 'package:citizens_voice_app/features/municipality/data/datasources/municipality_projects_remote_data_source.dart';

class MunicipalityProjectsRepositoryImpl
    implements IMunicipalityProjectsRepository {
  final MunicipalityProjectsRemoteDataSourceImpl
      _municipalityProjectsRemoteDataSourceImpl =
      MunicipalityProjectsRemoteDataSourceImpl();

  // Singleton
  static final MunicipalityProjectsRepositoryImpl _instance =
      MunicipalityProjectsRepositoryImpl._internal();

  factory MunicipalityProjectsRepositoryImpl() {
    return _instance;
  }

  MunicipalityProjectsRepositoryImpl._internal();

  @override
  Future<List<MunicipalityProjectEntity>> getOngoingProjects() {
    return _municipalityProjectsRemoteDataSourceImpl.getOngoingProjects();
  }

  @override
  Future<List<MunicipalityProjectEntity>> getArchivedProjects() async {
    return await _municipalityProjectsRemoteDataSourceImpl
        .getArchivedProjects();
  }

  @override
  Future<Map<String, dynamic>> voteForProject(String projectId, String vote) {
    return _municipalityProjectsRemoteDataSourceImpl.voteForProject(
        projectId, vote);
  }

  @override
  Future<void> addCommentToProject(
      String projectId, String comment, String commenter, String commenterId) {
    return _municipalityProjectsRemoteDataSourceImpl.addCommentToProject(
      projectId,
      comment,
      commenter,
      commenterId,
    );
  }
}
