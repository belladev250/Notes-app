import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/note_model.dart';
import '../../../domain/repositories/notes_repository_interface.dart';
import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepositoryInterface _notesRepository;

  NotesBloc({required NotesRepositoryInterface notesRepository})
      : _notesRepository = notesRepository,
        super(NotesInitial()) {
    on<NotesFetchRequested>(_onNotesFetchRequested);
    on<NotesAddRequested>(_onNotesAddRequested);
    on<NotesUpdateRequested>(_onNotesUpdateRequested);
    on<NotesDeleteRequested>(_onNotesDeleteRequested);
  }

  Future<void> _onNotesFetchRequested(
      NotesFetchRequested event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await _notesRepository.fetchNotes(event.userId);
      emit(NotesLoaded(notes));
    } catch (e) {
      emit(NotesError('Failed to fetch notes: $e'));
    }
  }

  Future<void> _onNotesAddRequested(
      NotesAddRequested event, Emitter<NotesState> emit) async {
    try {
      final note = NoteModel.create(
        content: event.content,
        userId: event.userId,
      );

      await _notesRepository.addNote(note);

      // Refresh the notes list
      final notes = await _notesRepository.fetchNotes(event.userId);
      emit(NotesOperationSuccess(
        message: 'Note added successfully',
        notes: notes,
      ));
    } catch (e) {
      emit(NotesError('Failed to add note: $e'));
    }
  }

  Future<void> _onNotesUpdateRequested(
      NotesUpdateRequested event, Emitter<NotesState> emit) async {
    try {
      await _notesRepository.updateNote(event.noteId, event.content);

      // Get current user ID from the current state
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        if (currentNotes.isNotEmpty) {
          final userId = currentNotes.first.userId;
          final notes = await _notesRepository.fetchNotes(userId);
          emit(NotesOperationSuccess(
            message: 'Note updated successfully',
            notes: notes,
          ));
        }
      } else if (state is NotesOperationSuccess) {
        final currentNotes = (state as NotesOperationSuccess).notes;
        if (currentNotes.isNotEmpty) {
          final userId = currentNotes.first.userId;
          final notes = await _notesRepository.fetchNotes(userId);
          emit(NotesOperationSuccess(
            message: 'Note updated successfully',
            notes: notes,
          ));
        }
      }
    } catch (e) {
      emit(NotesError('Failed to update note: $e'));
    }
  }

  Future<void> _onNotesDeleteRequested(
      NotesDeleteRequested event, Emitter<NotesState> emit) async {
    try {
      await _notesRepository.deleteNote(event.noteId);

      // Get current user ID from the current state
      if (state is NotesLoaded) {
        final currentNotes = (state as NotesLoaded).notes;
        if (currentNotes.isNotEmpty) {
          final userId = currentNotes.first.userId;
          final notes = await _notesRepository.fetchNotes(userId);
          emit(NotesOperationSuccess(
            message: 'Note deleted successfully',
            notes: notes,
          ));
        }
      } else if (state is NotesOperationSuccess) {
        final currentNotes = (state as NotesOperationSuccess).notes;
        if (currentNotes.isNotEmpty) {
          final userId = currentNotes.first.userId;
          final notes = await _notesRepository.fetchNotes(userId);
          emit(NotesOperationSuccess(
            message: 'Note deleted successfully',
            notes: notes,
          ));
        }
      }
    } catch (e) {
      emit(NotesError('Failed to delete note: $e'));
    }
  }
}
