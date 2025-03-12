import 'package:flutter/material.dart';
import 'package:flutter_web_api/screens/home_screen/widgets/home_screen_list.dart';
import 'package:flutter_web_api/services/dao/journal_dao_impl.dart';

import '../../domain/models/journal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // O último dia apresentado na lista
  DateTime currentDay = DateTime.now();

  JournalDAOimpl journalDAOimpl = JournalDAOimpl();

  // Tamanho da lista
  int windowPage = 10;

  // A base de dados mostrada na lista
  Map<String, Journal> database = {};

  final ScrollController _listScrollController = ScrollController();

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Título basado no dia atual
        title: Text(
          "${currentDay.day}  |  ${currentDay.month}  |  ${currentDay.year}",
        ),
        actions: [
          IconButton(
            onPressed: () {
              refresh();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView(
        controller: _listScrollController,
        children: generateListJournalCards(
          windowPage: windowPage,
          currentDay: currentDay,
          database: database,
          refreshFunction: refresh
        ),
      ),
    );
  }

  void refresh() async{
     List<Journal> listJournal = await journalDAOimpl.getAll();
    setState(() {
     
      database = {};

      for (Journal journal in listJournal) {
        database[journal.id] = journal;
      }
    });
  }
}
