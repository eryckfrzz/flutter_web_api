import 'package:flutter/material.dart';
import 'package:flutter_web_api/domain/models/journal.dart';
import 'package:flutter_web_api/screens/add_journal_screen/add_journal_screen.dart';
import 'package:flutter_web_api/screens/home_screen/home_screen.dart';
import 'package:flutter_web_api/screens/login_screen/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
      initialRoute: "login",
      routes: {
        "home": (context) => const HomeScreen(),
        "login": (context) => LoginScreen(),
      },
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
