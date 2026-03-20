import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'inventario.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {

        // PRODUCTOS
        await db.execute('''
        CREATE TABLE productos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          codigo TEXT,
          cantidad INTEGER
        )
        ''');

        // USUARIOS
        await db.execute('''
        CREATE TABLE usuarios(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          usuario TEXT UNIQUE,
          password TEXT
        )
        ''');

        // ADMIN
        await db.insert("usuarios", {
          "usuario": "admin",
          "password": sha256.convert(utf8.encode("1234")).toString()
        });
      },
    );
  }

  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  Future<bool> loginUsuario(String user, String pass) async {
    final db = await database;

    final result = await db.query(
      "usuarios",
      where: "usuario = ? AND password = ?",
      whereArgs: [user, hashPassword(pass)],
    );

    return result.isNotEmpty;
  }

  Future<void> insertarProducto(Map<String, dynamic> producto) async {
    final db = await database;
    await db.insert("productos", producto);
  }

  Future<List<Map<String, dynamic>>> obtenerProductos() async {
    final db = await database;
    return await db.query("productos");
  }
}
