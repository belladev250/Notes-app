import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository_interface.dart';
import '../models/note_model.dart';

class NotesRepository implements NotesRepositoryInterface {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'notes';

  @override
  Future<List<Note>> fetchNotes(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection(_collection)
          .where('userId', isEqualTo: userId)
          .get();

      final notes = querySnapshot.docs
          .map((doc) => NoteModel.fromFirestore(doc))
          .toList();

      // Sort in memory by updatedAt descending
      notes.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      return notes;
    } catch (e) {
      throw Exception('Failed to fetch notes: $e');
    }
  }

  @override
  Future<void> addNote(Note note) async {
    try {
      final noteModel = note as NoteModel;
      await _firestore.collection(_collection).add(noteModel.toFirestore());
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  @override
  Future<void> updateNote(String noteId, String content) async {
    try {
      await _firestore.collection(_collection).doc(noteId).update({
        'content': content,
        'updatedAt': Timestamp.fromDate(DateTime.now()),
      });
    } catch (e) {
      throw Exception('Failed to update note: $e');
    }
  }

  @override
  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore.collection(_collection).doc(noteId).delete();
    } catch (e) {
      throw Exception('Failed to delete note: $e');
    }
  }
}
