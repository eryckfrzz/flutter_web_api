import 'package:flutter/material.dart';
import 'package:flutter_web_api/helpers/weekday.dart';
import 'package:flutter_web_api/domain/models/journal.dart';
import 'package:flutter_web_api/services/dao/journal_dao_impl.dart';
import 'package:uuid/uuid.dart';

class JournalCard extends StatelessWidget {
  final Journal? journal;
  final DateTime showedDate;
  final Function refreshFunction;
  const JournalCard({
    super.key,
    this.journal,
    required this.showedDate,
    required this.refreshFunction,
  });

  @override
  Widget build(BuildContext context) {
    if (journal != null) {
      return InkWell(
        onTap: () {
          callAddJournalScreen(context, journal: journal);
        },
        child: Container(
          height: 115,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: Colors.black87)),
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.black54,
                      border: Border(
                        right: BorderSide(color: Colors.black87),
                        bottom: BorderSide(color: Colors.black87),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      journal!.createdAt.day.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 38,
                    width: 75,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      border: Border(right: BorderSide(color: Colors.black87)),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(WeekDay(journal!.createdAt.weekday).short),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    journal!.content,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  removeJournal(context);
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          callAddJournalScreen(context);
        },
        child: Container(
          height: 115,
          alignment: Alignment.center,
          child: Text(
            "${WeekDay(showedDate.weekday).short} - ${showedDate.day}",
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  callAddJournalScreen(BuildContext context, {Journal? journal}) {
    Journal innerJournal = Journal(
      id: Uuid().v1(),
      content: "",
      createdAt: showedDate,
      updatedAt: showedDate,
    );

    Map<String, dynamic> map = {};

    if (journal != null) {
      innerJournal = journal;
      map['is_editing'] = false;
    } else {
      map['is_editing'] = true;
    }

    map['journal'] = innerJournal;

    Navigator.pushNamed(context, 'journal-add', arguments: map).then((value) {
      refreshFunction();
      if (value != null && value == true) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registro feito com sucesso!')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Registro mal sucedido!')));
      }
    });
  }

  removeJournal(BuildContext context) {
    JournalDAOimpl journalDAOimpl = JournalDAOimpl();

    if (journal != null) {
      journalDAOimpl.delete(journal!.id).then((value) {
        if (value) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Removido com sucesso!')));

          refreshFunction();
        }
      });
    }
  }
}
