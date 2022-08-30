import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:tracking_odoo/src/database/newdatabase.dart';
import 'package:tracking_odoo/src/models/move_line_model.dart';
import 'dart:convert';
import '../models/Picking_model.dart';
import '../utils/helpers.dart';

class PickingDao {
  PickingDao();
  static Future<void> create(List pickings) async {
    try {
      final db = await NewDBProvider.db.database;
      final batch = db.batch();
      for (var element in pickings) {
        //print(element);
        batch.insert('pickings', Map.from(element),
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
      await batch.commit(noResult: true, continueOnError: true);
    } catch (e) {
      print('Error en la escritura de la tabla');
    }
  }


  static Future<List<PickingModel>> readAll() async {
      try {
        final db = await NewDBProvider.db.database;
        final contacts = await db.query('pickings');
        return contacts
            .map((element) => PickingModel.fromJson(element))
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
      await db.delete('pickings');
    } catch (e) {
      print(e);
      print('Hubo un error en deleteAll PickingModel');
    }
  }
   static Future<List<MoveLineModel>> getMoveLine(id) async { 
    try {
      final db = await NewDBProvider.db.database;
      final ids_move = await db.query('pickings',
          columns: ['move_line_ids'], where: 'id = ?', whereArgs: ['$id']);
      
      final lista_provisional = [115869,115924,117515,117516,117517];
      final move_line_models = [];
      for (var id_move in lista_provisional) {
        final move_line = await db.query('movelines', where: 'id = ?', whereArgs: ['$id_move']);
        move_line_models.add(move_line[0]);};
      //print(move_line_models);
      return move_line_models.map((modelo) => MoveLineModel.fromJson(modelo)).toList();
      //return [];

    } catch (e){
      print('Error en getMoveLine');
      print(e);
      return [];
    }
   }
}

