abstract class IUserRepository {
  Future<void> addUserVoteInParliament(
      String roundId, String projectId, String voteOption);

  Future<void> addUserVoteInMunicipality(String projectId, String voteOption);
}
