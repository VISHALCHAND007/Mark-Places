import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> initDb([String table = "places"]) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $table(id TEXT PRIMARY KEY, title TEXT, image TEXT, latitude REAL, longitude REAL)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> values) async {
    final db = await initDb(table);
    db.insert(table, values, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> fetchPlaces([
    String table = "places",
  ]) async {
    final db = await initDb(table);
    return db.query(table);
  }
}
