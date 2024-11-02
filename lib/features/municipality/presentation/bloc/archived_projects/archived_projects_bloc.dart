import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/const.dart';
import 'package:citizens_voice_app/features/municipality/data/repositories/municipality_projects_repository_impl.dart';
import 'package:flutter/material.dart';
part 'archived_projects_event.dart';
part 'archived_projects_state.dart';

class ArchivedProjectsBloc
    extends Bloc<ArchivedProjectsEvent, ArchivedProjectsState> {
  final AuthRemoteDataSourceImpl _authRemoteDataSourceImpl =
      AuthRemoteDataSourceImpl();
  final MunicipalityProjectsRepositoryImpl municipalityProjectsRepositoryImpl =
      MunicipalityProjectsRepositoryImpl();
  late List<MunicipalityProjectEntity> _archivedProjects;
  late CustomUserEntity _user;

  ArchivedProjectsBloc() : super(ArchivedProjectsInitial()) {
    on<LoadArchivedProjects>(_onLoadArchivedProjects);

    add(LoadArchivedProjects());
  }

  void _onLoadArchivedProjects(
      LoadArchivedProjects event, Emitter<ArchivedProjectsState> emit) async {
    emit(ArchivedProjectsLoading());
    try {
      _user = await _authRemoteDataSourceImpl.getCustomUser();
      _archivedProjects =
          await municipalityProjectsRepositoryImpl.getArchivedProjects();

      // assign userVote to each project
      for (MunicipalityProjectEntity project in _archivedProjects) {
        if (_user.municipalityVotes[project.id] != null) {
          project.userVote = _user.municipalityVotes[project.id] == kAgree
              ? kAgreeAr
              : kDisagreeAr;
        }
      }

      // sort projects by project's dateOfPost
      _archivedProjects.sort((a, b) => b.dateOfPost.compareTo(a.dateOfPost));

      emit(ArchivedProjectsLoaded());
    } catch (e) {
      emit(ArchivedProjectsError(
          'حدث خطأ أثناء تحميل المشاريع، يرجى المحاولة مرة أخرى'));
    }
  }

  List<MunicipalityProjectEntity> get archivedProjects => _archivedProjects;
}
