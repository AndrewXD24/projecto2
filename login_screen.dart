import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController usuario = TextEditingController();
  TextEditingController password = TextEditingController();

  String error = "";
  DBHelper db = DBHelper();

  void login() async {

    bool existe = await db.loginUsuario(
      usuario.text,
      password.text,
    );

    if (!mounted) return;

    if (existe) {

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
        ),
      );

    } else {

      setState(() {
        error = "Usuario o contraseña incorrectos";
      });

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [

            TextField(
              controller: usuario,
              decoration: const InputDecoration(
                labelText: "Usuario",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: login,
              child: const Text("Ingresar"),
            ),

            const SizedBox(height: 10),

            Text(
              error,
              style: const TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
