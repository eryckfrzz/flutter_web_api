import 'package:flutter/material.dart';
import 'package:flutter_web_api/helpers/weekday.dart';
import 'package:flutter_web_api/domain/models/journal.dart';

class AddJournalScreen extends StatelessWidget {
  Journal journal = Journal(
    id: 'id',
    content: 'content',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
  AddJournalScreen({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${WeekDay(journal.createdAt.weekday).long.toLowerCase()} | ${journal.createdAt.day} | ${journal.createdAt.month} | ${journal.createdAt.year}',
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
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
