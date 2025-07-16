class Note {
  final String id;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String userId;

  Note({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
  });
}
