class SuggestionEntity {
  String id;
  String uid;
  String name;
  String title;
  String details;
  DateTime dateOfPost;
  String type;
  List<String> tags;
  int upvotesCount;
  List<String> upvoters;
  List<Map<String,dynamic>> comments;

  SuggestionEntity({
    required this.id,
    required this.uid,
    required this.name,
    required this.title,
    required this.details,
    required this.dateOfPost,
    required this.type,
    required this.tags,
    required this.upvotesCount,
    required this.upvoters,
    required this.comments,
  });
}