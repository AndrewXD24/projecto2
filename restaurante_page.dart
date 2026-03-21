import 'package:flutter/material.dart';
import '../service/inventario_services.dart';
import '../models/restaurante_insumo_model.dart';

class RestaurantePage extends StatelessWidget {
  const RestaurantePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventario de Cocina")),
      body: FutureBuilder<List<dynamic>>(
        future: InventarioService().fetchRestauranteInsumos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (!snapshot.hasData || snapshot.data!.isEmpty) return const Center(child: Text("Sin datos en cocina"));

          final insumos = snapshot.data!.map((e) => RestauranteInsumo.fromJson(e)).toList();

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: insumos.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final item = insumos[index];
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.restaurant)),
                title: Text(item.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(item.categoria),
                trailing: Text("${item.stock} ${item.unidad}", 
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              );
            },
          );
        },
      ),
    );
  }
}
