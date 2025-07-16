import 'package:equatable/equatable.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class NotesFetchRequested extends NotesEvent {
  final String userId;

  const NotesFetchRequested(this.userId);

  @override
  List<Object> get props => [userId];
}

class NotesAddRequested extends NotesEvent {
  final String content;
  final String userId;

  const NotesAddRequested({required this.content, required this.userId});

  @override
  List<Object> get props => [content, userId];
}

class NotesUpdateRequested extends NotesEvent {
  final String noteId;
  final String content;

  const NotesUpdateRequested({required this.noteId, required this.content});

  @override
  List<Object> get props => [noteId, content];
}

class NotesDeleteRequested extends NotesEvent {
  final String noteId;

  const NotesDeleteRequested(this.noteId);

  @override
  List<Object> get props => [noteId];
}
