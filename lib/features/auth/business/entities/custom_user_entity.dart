class CustomUserEntity {
  final String uid;
  final String nationalId;
  final String fullName;
  final String residence;
  final String phoneNumber;
  final Map<String, dynamic> parliamentVotes;
  final Map<String, dynamic> municipalityVotes;
  final Map<String, dynamic> municipalityProjectsCommented;

  CustomUserEntity({
    required this.uid,
    required this.nationalId,
    required this.fullName,
    required this.residence,
    required this.phoneNumber,
    required this.parliamentVotes,
    required this.municipalityVotes,
    this.municipalityProjectsCommented = const {},
  });
}
