import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'scan_qr_screen.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  TextEditingController nombre = TextEditingController();
  TextEditingController codigo = TextEditingController();
  TextEditingController cantidad = TextEditingController();

  DBHelper db = DBHelper();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Producto")),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            TextField(controller: nombre, decoration: const InputDecoration(labelText: "Nombre")),

            TextField(controller: codigo, decoration: const InputDecoration(labelText: "Código QR")),

            ElevatedButton(
              child: const Text("Escanear QR"),
              onPressed: () async {

                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ScanQRScreen()),
                );

                if (!mounted) return;

                if (result != null) {
                  codigo.text = result;
                }
              },
            ),

            TextField(
              controller: cantidad,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Cantidad"),
            ),

            ElevatedButton(
              child: const Text("Guardar"),
              onPressed: () async {

                await db.insertarProducto({
                  "nombre": nombre.text,
                  "codigo": codigo.text,
                  "cantidad": int.parse(cantidad.text)
                });

                if (!mounted) return;

                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
