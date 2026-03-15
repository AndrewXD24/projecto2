import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import 'add_product_screen.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {

  List productos = [];
  DBHelper db = DBHelper();

  void cargarProductos() async {

    final data = await db.obtenerProductos();

    setState(() {
      productos = data;
    });

  }

  @override
  void initState() {
    super.initState();
    cargarProductos();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Inventario"),
      ),

      body: ListView.builder(

        itemCount: productos.length,

        itemBuilder: (context, index) {

          final producto = productos[index];

          return ListTile(
            title: Text(producto['nombre']),
            subtitle: Text("Cantidad: ${producto['cantidad']}"),
          );

        },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddProductScreen(),
            ),
          );

          cargarProductos();
        },
      ),
    );
  }
}
