import 'package:flutter/material.dart';
import 'package:flutter_web_api/domain/models/journal.dart';
import 'package:flutter_web_api/screens/add_journal_screen/add_journal_screen.dart';
import 'package:flutter_web_api/services/dao/journal_dao_impl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen/home_screen.dart';

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

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: "home",
      routes: {"home": (context) => const HomeScreen()},
      onGenerateRoute: (settings) {
        if (settings.name == 'journal-add') {
          Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
          final Journal journal = map['journal'] as Journal;
          final bool isEditing = map['is_editing'];

          return MaterialPageRoute(
            builder: (context) {
              return AddJournalScreen(journal: journal, isEditing: isEditing);
            },
          );
        }
        return null;
      },
    );
  }
}
