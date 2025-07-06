// lib/blocs/notes_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/repositories/notes_repository.dart';

// Events
abstract class NotesEvent extends Equatable {
  const NotesEvent();
  @override
  List<Object?> get props => [];
}

class FetchNotes extends NotesEvent {}

class AddNote extends NotesEvent {
  final String title;
  final String content;

  const AddNote({required this.title, required this.content});

  @override
  List<Object?> get props => [title, content];
}

class UpdateNote extends NotesEvent {
  final Note note;

  const UpdateNote({required this.note});

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NotesEvent {
  final String noteId;

  const DeleteNote({required this.noteId});

  @override
  List<Object?> get props => [noteId];
}

// States
abstract class NotesState extends Equatable {
  const NotesState();
  @override
  List<Object?> get props => [];
}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesLoaded extends NotesState {
  final List<Note> notes;

  const NotesLoaded({required this.notes});

  @override
  List<Object?> get props => [notes];
}

class NotesError extends NotesState {
  final String message;

  const NotesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class NotesOperationSuccess extends NotesState {
  final List<Note> notes;
  final String message;

  const NotesOperationSuccess({required this.notes, required this.message});

  @override
  List<Object?> get props => [notes, message];
}

// Bloc
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository _notesRepository;

  NotesBloc({required NotesRepository notesRepository})
    : _notesRepository = notesRepository,
      super(NotesInitial()) {
    on<FetchNotes>(_onFetchNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onFetchNotes(FetchNotes event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    try {
      final notes = await _notesRepository.getNotes();
      emit(NotesLoaded(notes: notes));
    } catch (e) {
      emit(NotesError(message: e.toString()));
    }
  }

  Future<void> _onAddNote(AddNote event, Emitter<NotesState> emit) async {
    try {
      final newNote = Note(
        id: '', // Will be set by repository
        title: event.title,
        content: event.content,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _notesRepository.createNote(newNote);
      final notes = await _notesRepository.getNotes();
      emit(
        NotesOperationSuccess(notes: notes, message: 'Note added successfully'),
      );
    } catch (e) {
      emit(NotesError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NotesState> emit) async {
    try {
      await _notesRepository.updateNote(event.note);
      final notes = await _notesRepository.getNotes();
      emit(
        NotesOperationSuccess(
          notes: notes,
          message: 'Note updated successfully',
        ),
      );
    } catch (e) {
      emit(NotesError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNote(DeleteNote event, Emitter<NotesState> emit) async {
    try {
      await _notesRepository.deleteNote(event.noteId);
      final notes = await _notesRepository.getNotes();
      emit(
        NotesOperationSuccess(
          notes: notes,
          message: 'Note deleted successfully',
        ),
      );
    } catch (e) {
      emit(NotesError(message: e.toString()));
    }
  }
}
