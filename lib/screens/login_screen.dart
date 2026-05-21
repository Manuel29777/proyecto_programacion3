import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user = TextEditingController();

  TextEditingController pass = TextEditingController();

  int totalLogins = 0;

  void login() {
    if (user.text == "admin" && pass.text == "1234") {
      totalLogins++;

      Navigator.push(
        context,

        MaterialPageRoute(builder: (_) => HomeScreen(totalLogins)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),

      body: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: user,

              decoration: InputDecoration(labelText: 'Usuario'),
            ),

            TextField(
              controller: pass,

              obscureText: true,

              decoration: InputDecoration(labelText: 'Contraseña'),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: login, child: Text('Ingresar')),
          ],
        ),
      ),
    );
  }
}
