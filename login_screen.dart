import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              decoration: const InputDecoration(
                labelText: "Usuario",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Contraseña",
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );

              },
              child: const Text("Ingresar"),
            )

          ],
        ),
      ),
    );
  }
}
