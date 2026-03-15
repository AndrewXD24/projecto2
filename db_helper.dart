import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

        await db.execute('''
        CREATE TABLE productos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nombre TEXT,
          codigo TEXT,
          cantidad INTEGER
        )
        ''');

      },
    );
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
