import 'package:flutter/material.dart';
import 'package:flutter_web_api/helpers/weekday.dart';
import 'package:flutter_web_api/domain/models/journal.dart';
import 'package:flutter_web_api/services/dao/journal_dao_impl.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;
  final bool isEditing;
  AddJournalScreen({super.key, required this.journal, required this.isEditing});

  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _contentController.text = journal.content;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${WeekDay(journal.createdAt.weekday).long.toLowerCase()} | ${journal.createdAt.day} | ${journal.createdAt.month} | ${journal.createdAt.year}',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String content = _contentController.text;

              journal.content = content;

              JournalDAOimpl journalDAOimpl = JournalDAOimpl();

              if (isEditing) {
                final result = await journalDAOimpl.register(journal);

                Navigator.pop(context, result);
              } else {
                final result = journalDAOimpl.update(journal.id, journal);

                Navigator.pop(context, result);
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _contentController,
          expands: true,
          keyboardType: TextInputType.multiline,
          style: TextStyle(fontSize: 24),
          maxLines: null,
          minLines: null,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
