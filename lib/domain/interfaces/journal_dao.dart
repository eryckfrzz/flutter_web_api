import 'package:flutter_web_api/domain/models/journal.dart';

abstract class JournalDAO {
  register(Journal journal);

  delete(int id);

  Future<List<Journal>> getAll();

  update(Journal journal);
}
