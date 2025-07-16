import '../entities/note.dart';

abstract class NotesRepositoryInterface {
  Future<List<Note>> fetchNotes(String userId);
  Future<void> addNote(Note note);
  Future<void> updateNote(String noteId, String content);
  Future<void> deleteNote(String noteId);
}