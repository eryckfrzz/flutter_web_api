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
  Future<bool> login({required String email, required String password}) async {
    try {
      http.Response response = await client.post(
        Uri.parse('${apiUrl.url}/login'),
        //Uri.parse('http://192.168.10.101:3000/login'),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        print("Login realizado com sucesso!");
        return true;
      } else {
        print('Erro: ${response.statusCode}');
        print(response.body);

        // String content = json.decode(response.body);
        // switch (content) {
        //   case 'Cannot find user':
        //     throw UserNotFindException();
        // }
      }
    } catch (e) {
      print(e);
      print("Erro ao registar!");
    }

    return false;
  }

  @override
  Future<bool>register({required String email, required String password}) async {

    try {
      http.Response response = await client.post(
      Uri.parse('${apiUrl.url}/register'),
      body: {'email': email, 'password': password},
    );

      if (response.statusCode != 200) {

        print('Erro: ${response.statusCode}');
        print(response.body);
        
      } else {
        print("Cadastro realizado com sucesso!");
        return true;
      }
      
    } catch (e) {
      print(e);
      print("Erro ao registar!");
    }

    return false;
    
    
  }
}

// class UserNotFindException implements Exception {}
