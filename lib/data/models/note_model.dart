import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/note.dart';

class NoteModel extends Note {
  NoteModel({
    required super.id,
    required super.content,
    required super.createdAt,
    required super.updatedAt,
    required super.userId,
  });

  factory NoteModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NoteModel(
      id: doc.id,
      content: data['content'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'userId': userId,
    };
  }

  factory NoteModel.create({
    required String content,
    required String userId,
  }) {
    final now = DateTime.now();
    return NoteModel(
      id: '', // Firestore will generate this
      content: content,
      createdAt: now,
      updatedAt: now,
      userId: userId,
    );
  }

  NoteModel copyWith({
    String? id,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? userId,
  }) {
    return NoteModel(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
    );
  }
}
