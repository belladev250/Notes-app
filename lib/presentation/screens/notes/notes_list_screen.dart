import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/custom_snackbar.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../bloc/auth/auth_bloc.dart';
import '../../bloc/auth/auth_event.dart';
import '../../bloc/auth/auth_state.dart';
import '../../bloc/notes/notes_bloc.dart';
import '../../bloc/notes/notes_event.dart';
import '../../bloc/notes/notes_state.dart';
import '../../widgets/note_card.dart';
import '../../widgets/note_input_dialog.dart';
import '../auth/login_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notes when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthBloc>().state;
      if (authState is AuthAuthenticated) {
        context.read<NotesBloc>().add(NotesFetchRequested(authState.user.uid));
      }
    });
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) => NoteInputDialog(
        title: 'Add New Note',
        onSave: (content) {
          final authState = context.read<AuthBloc>().state;
          if (authState is AuthAuthenticated) {
            context.read<NotesBloc>().add(
                  NotesAddRequested(
                    content: content,
                    userId: authState.user.uid,
                  ),
                );
          }
        },
      ),
    );
  }

  void _showEditNoteDialog(String noteId, String currentContent) {
    showDialog(
      context: context,
      builder: (context) => NoteInputDialog(
        title: 'Edit Note',
        initialContent: currentContent,
        onSave: (content) {
          context.read<NotesBloc>().add(
                NotesUpdateRequested(noteId: noteId, content: content),
              );
        },
      ),
    );
  }

  void _showDeleteConfirmation(String noteId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<NotesBloc>().add(NotesDeleteRequested(noteId));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _signOut() {
    context.read<AuthBloc>().add(AuthSignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is AuthUnauthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Notes'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _signOut,
              tooltip: 'Sign Out',
            ),
          ],
        ),
        body: BlocConsumer<NotesBloc, NotesState>(
          listener: (context, state) {
            if (state is NotesError) {
              CustomSnackbar.showError(context, state.message);
            } else if (state is NotesOperationSuccess) {
              CustomSnackbar.showSuccess(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is NotesLoading) {
              return const LoadingWidget(message: 'Loading your notes...');
            }

            if (state is NotesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Something went wrong',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        final authState = context.read<AuthBloc>().state;
                        if (authState is AuthAuthenticated) {
                          context
                              .read<NotesBloc>()
                              .add(NotesFetchRequested(authState.user.uid));
                        }
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );
            }

            final notes = state is NotesLoaded
                ? state.notes
                : state is NotesOperationSuccess
                    ? state.notes
                    : <dynamic>[];

            if (notes.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_add_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Nothing here yet—tap ➕ to add a note.',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(
                  note: note,
                  onEdit: () => _showEditNoteDialog(note.id, note.content),
                  onDelete: () => _showDeleteConfirmation(note.id),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddNoteDialog,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
