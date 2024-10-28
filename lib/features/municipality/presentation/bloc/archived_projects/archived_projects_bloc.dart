import 'package:bloc/bloc.dart';
import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/data/repositories/municipality_projects_repository_impl.dart';
import 'package:flutter/material.dart';
part 'archived_projects_event.dart';
part 'archived_projects_state.dart';

class ArchivedProjectsBloc
    extends Bloc<ArchivedProjectsEvent, ArchivedProjectsState> {
  final MunicipalityProjectsRepositoryImpl municipalityProjectsRepositoryImpl =
      MunicipalityProjectsRepositoryImpl();
  late List<MunicipalityProjectEntity> _archivedProjects;
  ArchivedProjectsBloc() : super(ArchivedProjectsInitial()) {
    on<LoadArchivedProjects>(_onLoadArchivedProjects);

    add(LoadArchivedProjects());
  }

  void _onLoadArchivedProjects(
      LoadArchivedProjects event, Emitter<ArchivedProjectsState> emit) async {
    emit(ArchivedProjectsLoading());
    try {
      _archivedProjects =
          await municipalityProjectsRepositoryImpl.getArchivedProjects();

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
