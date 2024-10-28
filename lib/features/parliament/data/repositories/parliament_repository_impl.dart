import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';
import 'package:citizens_voice_app/features/parliament/business/repositories/parliament_repository.dart';
import 'package:citizens_voice_app/features/parliament/data/datasources/parliament_rounds_remote_data_source.dart';

class ParliamentRepositoryImpl implements IParliamentRepository {
  final ParliamentRoundsDataSourceImpl _parliamentRoundsDataSourceImpl =
      ParliamentRoundsDataSourceImpl();

  // Singleton
  static final ParliamentRepositoryImpl _instance =
      ParliamentRepositoryImpl._internal();

  factory ParliamentRepositoryImpl() {
    return _instance;
  }

  ParliamentRepositoryImpl._internal();

  @override
  Future<List<ParliamentRoundEntity>> getArchivedRounds() {
    return _parliamentRoundsDataSourceImpl.getArchivedRounds();
  }

  @override
  Future<ParliamentRoundEntity> getOngoingRound() {
    return _parliamentRoundsDataSourceImpl.getOngoingRound();
  }

  @override
  Future<ParliamentRoundEntity> getOngoingRoundInfo() {
    return _parliamentRoundsDataSourceImpl.getOngoingRoundInfo();
  }

  @override
  Future<Map<String, dynamic>> voteForProject(
      String roundId, String projectId, String vote) {
      return _parliamentRoundsDataSourceImpl.voteForProject(roundId, projectId, vote);
  }
}
