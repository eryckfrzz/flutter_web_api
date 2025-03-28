import 'package:flutter/material.dart';
import 'package:flutter_web_api/domain/models/journal.dart';
import 'package:flutter_web_api/my_app.dart';
import 'package:flutter_web_api/services/dao/journal_dao_impl.dart';


void main() async {
  runApp(const MyApp());

  JournalDAOimpl journalDAOimpl = JournalDAOimpl();

  Journal journalVazio = Journal.empty();

  //await journalDAOimpl.getAll();

  // await journalDAOimpl.register(
  //   journalVazio
  // );

  //await journalDAOimpl.getAll();
  //await service.register("Olá mundo");

  //await service.get();
}

