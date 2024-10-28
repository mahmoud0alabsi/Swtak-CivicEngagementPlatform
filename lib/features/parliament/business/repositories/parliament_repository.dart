import 'package:citizens_voice_app/features/parliament/business/entities/parliament_round_entity.dart';

abstract class IParliamentRepository {
  Future<ParliamentRoundEntity> getOngoingRound();
  Future<List<ParliamentRoundEntity>> getArchivedRounds();
  Future<ParliamentRoundEntity>
      getOngoingRoundInfo(); // return round without its projects - for Home page

  Future<Map<String, dynamic>> voteForProject(String roundId, String projectId, String vote);
}
