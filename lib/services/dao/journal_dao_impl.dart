import 'dart:convert';

import 'package:flutter_web_api/domain/interfaces/journal_dao.dart';
import 'package:flutter_web_api/domain/models/journal.dart';
import 'package:flutter_web_api/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class JournalDAOimpl implements JournalDAO {
  http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()],
  );

  Uri uri = Uri.parse('http://192.168.10.106:3000/journals');

  @override
  Future<List<Journal>> getAll() async {
    try {
      http.Response response = await client.get(uri);

      if (response.statusCode == 200) {
        List<Journal> list = [];

        List<dynamic> listDynamic = json.decode(response.body);

        for (var jsonMap in listDynamic) {
          list.add(Journal.fromMap(jsonMap));
        }
        print(list.length);
        print("Resgistros pesquisados com sucesso!");
      } else {
        print('Erro: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
      print("Erro ao registrar!");
    }

    return [];
  }

  @override
  register(Journal journal) async {
    try {
      String jsonJournal = json.encode(journal.toMap());

      http.Response response = await client.post(
        uri,
        headers: {"content-type": "application/json"},
        body: jsonJournal,
      );

      if (response.statusCode == 201) {
        print("Resgistro criado com sucesso!");
      } else {
        print('Erro: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print(e);
      print("Erro ao registrar!");
    }
  }

  @override
  update(Journal journal) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }
}
