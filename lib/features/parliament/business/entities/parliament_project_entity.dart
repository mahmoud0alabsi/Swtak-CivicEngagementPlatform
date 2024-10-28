class ParliamentProjectEntity {
  String id;
  String title;
  String details;
  int projectNumber;
  String type;
  List<String> tags;
  String responsibleInstitution;
  Map<String, dynamic> voting;
  String userVote = '';
  // voting = {
  //  'aggree': 0,
  //  'disaggree': 0,
  // }

  ParliamentProjectEntity({
    required this.id,
    required this.title,
    required this.details,
    required this.projectNumber,
    required this.type,
    required this.tags,
    required this.responsibleInstitution,
    required this.voting,
  });
}
