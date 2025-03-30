import 'package:flutter/material.dart';
import 'package:flutter_web_api/screens/commom/confirmation_dialog.dart';
import 'package:flutter_web_api/services/dao/users_dao_impl.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  UsersDaoImpl service = UsersDaoImpl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          border: Border.all(width: 8),
          color: Colors.white,
        ),
        child: Form(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Icon(Icons.bookmark, size: 64, color: Colors.brown),
                  const Text(
                    "Simple Journal",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Divider(thickness: 2),
                  ),
                  const Text("Entre ou Registre-se"),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text(
                        "E-mail",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      label: Text(
                        "Senha",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    maxLength: 16,
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      login(context);
                    },
                    child: const Text("Continuar"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

  
      bool result = await service.login(email: email, password: password);

      if(result == false) {
        showConfirmationDialog(
          context,
          title: "Usuário ainda não existe!",
          content:
              "Deseja criar um novo usuário a partir do e-mail $email e a senha inserida?",
          affirmativeOption: "Criar",
        ).then((value) async{
          if (value) {
            await service.register(email: email, password: password);
          }
        },);
      }

      
    }
  }

