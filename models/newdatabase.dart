import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class NewDBProvider {
  static Database? _database;
  static final NewDBProvider db = NewDBProvider._();

  NewDBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'new_odoo_tracking.db');

    return await openDatabase(path,
        version: 1, onOpen: (db) {}, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      create table pickings (
        id INTEGER PRIMARY KEY,
        name TEXT,
        partner_id TEXT,
        picking_type_id TEXT,
        location_id TEXT,
        location_dest_id TEXT,
        move_line_ids BLOB,
        scheduled_date TEXT,
        date_deadline TEXT,
        origin TEXT
       )''');
    await db.execute('''
      create table movelines (
        id INTEGER PRIMARY KEY,
        date TEXT,
        reference TEXT,
        product_id TEXT,
        location_id TEXT,
        location_dest_id TEXT,
        product_uom_qty BLOB,
        qty_done TEXT,
        lot_id TEXT,
        package_id TEXT,
        result_package_id TEXT
       )''');
    }
  }
