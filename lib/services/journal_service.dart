import 'dart:convert';

import 'package:flutter_web_api/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class JournalService {
  static const String url = 'http://192.168.10.104:3000/';
  static const String resource = "learnhttp";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()],
  );

  String getURL() {
    return "$url$resource";
  }

  Future<void> register(String content) async {
    try {
      http.Response response = await client.post(
        Uri.parse(getURL()),
        body: jsonEncode({"content": content}),
      );

      if (response.statusCode == 200) {
        print('Registro bem-sucedido!');
      } else {
        print('Erro no registro: ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      print('Erro na requisição POST: $e');
    }
  }

Future<List<dynamic>> get() async {
    try {
      http.Response response = await client.get(Uri.parse(getURL()));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Erro na requisição GET: ${response.statusCode}');
        print(response.body);
        return [];
      }
    } catch (e) {
      print('Erro na requisição GET: $e');
      return []; 
    }
  }
}
