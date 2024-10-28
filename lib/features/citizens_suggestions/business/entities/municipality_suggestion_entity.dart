class MunicipalitySuggestionEntity {
  String id;
  String uid;
  String name;
  String title;
  String details;
  DateTime dateOfPost;
  String type;
  List<String> tags;
  String governorate;
  String area;
  String municipality;
  int upvotesCount;
  List<String> upvoters;
  List<Map<String,dynamic>> comments;

  MunicipalitySuggestionEntity({
    required this.id,
    required this.uid,
    required this.name,
    required this.title,
    required this.details,
    required this.dateOfPost,
    required this.type,
    required this.tags,
    required this.governorate,
    required this.area,
    required this.municipality,
    required this.upvotesCount,
    required this.upvoters,
    required this.comments,
  });
}