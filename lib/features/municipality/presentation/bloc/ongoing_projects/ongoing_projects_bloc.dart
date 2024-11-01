import 'package:citizens_voice_app/features/auth/business/entities/custom_user_entity.dart';
import 'package:citizens_voice_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:citizens_voice_app/features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'package:citizens_voice_app/features/municipality/business/entities/municipality_project_entity.dart';
import 'package:citizens_voice_app/features/municipality/const.dart';
import 'package:citizens_voice_app/features/municipality/data/repositories/municipality_projects_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ongoing_projects_event.dart';
part 'ongoing_projects_state.dart';

class OngoingProjectsBloc
    extends Bloc<OngoingProjectsEvent, OngoingProjectsState> {
  final AuthRemoteDataSourceImpl _authRemoteDataSourceImpl =
      AuthRemoteDataSourceImpl();
  final MunicipalityProjectsRepositoryImpl municipalityProjectsRepositoryImpl =
      MunicipalityProjectsRepositoryImpl();
  late List<MunicipalityProjectEntity> _ongoingProjects;
  late CustomUserEntity _user;

  OngoingProjectsBloc() : super(OngoingProjectsInitial()) {
    on<LoadOngoingProjects>(_onLoadProjects);
    on<VoteForProject>(_onVoteForProject);
    on<AddCommentToProject>(_onAddCommentToProject);

    add(LoadOngoingProjects());
  }

  void _onLoadProjects(
      LoadOngoingProjects event, Emitter<OngoingProjectsState> emit) async {
    emit(OngoingProjectsLoading());
    try {
      _user = await _authRemoteDataSourceImpl.getCustomUser();

      _ongoingProjects =
          await municipalityProjectsRepositoryImpl.getOngoingProjects();

      // sort projects by project's dateOfPost
      _ongoingProjects.sort((a, b) => b.dateOfPost.compareTo(a.dateOfPost));

      // assign userVote to each project
      for (MunicipalityProjectEntity project in _ongoingProjects) {
        if (_user.municipalityVotes[project.id] != null) {
          project.userVote = _user.municipalityVotes[project.id];
        }
      }

      emit(OngoingProjectsLoaded());
    } catch (e) {
      emit(OngoingProjectsError(
          'حدث خطأ أثناء تحميل المشاريع، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onVoteForProject(
      VoteForProject event, Emitter<OngoingProjectsState> emit) async {
    emit(VoteOnProjectLoading());
    try {
      String userVote = event.voteOption == kAgreeAr ? kAgree : kDisagree;
      // store vote in user's votes (users collection)
      event.context.read<UserManagerBloc>().add(AddUserVoteMunicipality(
            event.projectId,
            userVote,
          ));

      // store vote on selected project in the round
      for (MunicipalityProjectEntity project in _ongoingProjects) {
        if (project.id == event.projectId) {
          project.voting[userVote] += 1;
          project.userVote = userVote;
          break;
        }
      }

      await municipalityProjectsRepositoryImpl.voteForProject(
          event.projectId, userVote);

      emit(VoteOnProjectDone('تم التصويت بنجاح، شكراً لك على مشاركتك'));
    } catch (e) {
      emit(OngoingProjectsError(
          'حدث خطأ أثناء التصويت، يرجى المحاولة مرة أخرى'));
    }
  }

  void _onAddCommentToProject(
      AddCommentToProject event, Emitter<OngoingProjectsState> emit) async {
    emit(AddCommentToProjectLoading());
    try {
      // store comment in user's comments (users collection)
      event.context.read<UserManagerBloc>().add(AddCommentToMunicipalityProject(
            event.projectId,
            event.comment,
          ));

      await municipalityProjectsRepositoryImpl.addCommentToProject(
        event.projectId,
        event.comment,
        _user.fullName,
        _user.uid,
      );

      emit(AddCommentToProjectDone('تم إضافة التعليق بنجاح'));
    } catch (e) {
      emit(OngoingProjectsError(
          'حدث خطأ أثناء إضافة التعليق، يرجى المحاولة مرة أخرى'));
    }
  }

  List<MunicipalityProjectEntity> get ongoingProjects => _ongoingProjects;
}
