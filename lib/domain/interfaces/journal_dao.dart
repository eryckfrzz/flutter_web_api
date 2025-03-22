import 'package:flutter_web_api/domain/models/journal.dart';

abstract class JournalDAO {
  register(Journal journal);

  delete(String id);

  Future<List<Journal>> getAll();

  update(String id, Journal journal);
}
