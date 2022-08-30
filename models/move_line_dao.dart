import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:tracking_odoo/src/database/newdatabase.dart';
import 'dart:convert';
import '../models/Picking_model.dart';
import '../models/move_line_model.dart';
import '../utils/helpers.dart';

class MoveLineDao {
  MoveLineDao();
  
  static Future<void> create(List movelines) async {
    try {
      final db = await NewDBProvider.db.database;
      final batch = db.batch();
      for (var element in movelines) {
        //print(element);
        batch.insert('movelines', Map.from(element),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true, continueOnError: true);
    } catch (e) {
      print('Error en la escritura de la tabla');
    }
  }

  static Future<List<MoveLineModel>> readAll() async {
      try {
        final db = await NewDBProvider.db.database;
        final contacts = await db.query('movelines');
        return contacts
            .map((element) => MoveLineModel.fromJson(element))
            .toList();
      } catch (e) {
        print('Hubo un error en readAll PickingModel');
        print(e);
        return [];
      }
    }

    static Future<void> deleteAll() async {
    try {
      final db = await NewDBProvider.db.database;
      await db.delete('movelines');
    } catch (e) {
      print(e);
      print('Hubo un error en deleteAll MoveLine');
    }
  }

}