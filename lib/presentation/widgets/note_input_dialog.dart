import 'package:flutter/material.dart';
import '../../core/utils/validators.dart';

class NoteInputDialog extends StatefulWidget {
  final String title;
  final String? initialContent;
  final Function(String) onSave;

  const NoteInputDialog({
    super.key,
    required this.title,
    this.initialContent,
    required this.onSave,
  });

  @override
  State<NoteInputDialog> createState() => _NoteInputDialogState();
}

class _NoteInputDialogState extends State<NoteInputDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      widget.onSave(_controller.text.trim());
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          maxLines: 4,
          autofocus: true,
          validator: Validators.validateNoteContent,
          decoration: const InputDecoration(
            hintText: 'Enter your note here...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _save,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          child: Text(
            widget.initialContent == null ? 'Add' : 'Update',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}