class MunicipalityProjectEntity {
  String id;
  String title;
  String details;
  DateTime dateOfPost;
  int durationOfAvailability;
  int projectNumber;
  String type;
  List<String> tags;
  Map<String, dynamic> voting;
  // voting = {
  //  'aggree': 0,
  //  'disaggree': 0,
  // }
  bool isFinished = false;
  String userVote = '';
  DateTime dateOfEnd = DateTime.now();

  MunicipalityProjectEntity({
    required this.id,
    required this.title,
    required this.details,
    required this.dateOfPost,
    required this.durationOfAvailability,
    required this.type,
    required this.tags,
    required this.voting,
    required this.projectNumber,
    required this.isFinished,
  }) {
    dateOfEnd = dateOfPost.add(Duration(days: durationOfAvailability));
  }
}
