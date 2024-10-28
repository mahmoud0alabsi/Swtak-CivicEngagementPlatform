import 'package:citizens_voice_app/features/auth/business/repositories/user_repository.dart';
import 'package:citizens_voice_app/features/auth/data/datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDataSourceImpl _userRemoteDataSourceImpl =
      UserRemoteDataSourceImpl();

  // Singleton
  static final UserRepositoryImpl _instance = UserRepositoryImpl._internal();

  factory UserRepositoryImpl() {
    return _instance;
  }

  UserRepositoryImpl._internal();

  @override
  Future<void> addUserVoteInParliament(
      String roundId, String projectId, String voteOption) {
    return _userRemoteDataSourceImpl.addUserVoteInParliament(
        roundId, projectId, voteOption);
  }
  
  @override
  Future<void> addUserVoteInMunicipality(String projectId, String voteOption) {
    return _userRemoteDataSourceImpl.addUserVoteInMunicipality(projectId, voteOption);
  }
}
