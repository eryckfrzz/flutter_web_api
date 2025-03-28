import 'package:flutter_web_api/domain/interfaces/users_dao.dart';
import 'package:flutter_web_api/domain/models/url.dart';
import 'package:flutter_web_api/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class UsersDaoImpl implements UsersDao {
  http.Client client = InterceptedClient.build(
    interceptors: [LoggerInterceptor()],
  );

  Url apiUrl = Url();

  //Uri uri = Uri.parse('http://192.168.10.101:3000');

  @override
  login({required String email, required String password}) async {
    try {
      http.Response response = await client.post(
        Uri.parse('$apiUrl/login'),
        //Uri.parse('http://192.168.10.101:3000/login'),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        print("Login realizado com sucesso!");
        return response.body;
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
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }
}
