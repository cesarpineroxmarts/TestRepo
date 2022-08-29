// To parse this JSON data, do
//
//     final welcome = welcomeFromMap(jsonString);

import 'dart:convert';
import 'package:http/http.dart' as http;


class PickingModel {
    PickingModel({
        required this.jsonrpc,
        required this.id,
        required this.result,
    });

    String jsonrpc;
    dynamic id;
    Result result;

    factory PickingModel.fromJson(String str) => PickingModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory PickingModel.fromMap(Map<String, dynamic> json) => PickingModel(
        jsonrpc: json["jsonrpc"],
        id: json["id"],
        result: Result.fromMap(json["result"]),
    );

    Map<String, dynamic> toMap() => {
        "jsonrpc": jsonrpc,
        "id": id,
        "result": result.toMap(),
    };
}

class Result {
    Result({
        required this.ok,
        required this.data,
        required this.msg,
    });

    bool ok;
    List<Datum> data;
    String msg;

    factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Result.fromMap(Map<String, dynamic> json) => Result(
        ok: json["ok"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
        msg: json["msg"],
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
        "msg": msg,
    };
}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.partnerId,
        required this.pickingTypeId,
        required this.locationId,
        required this.locationDestId,
        required this.moveLineIds,
        required this.scheduledDate,
        required this.dateDeadline,
        required this.origin,
    });

    int id;
    String name;
    String partnerId;
    String pickingTypeId;
    String locationId;
    String locationDestId;
    List<int> moveLineIds;
    DateTime scheduledDate;
    bool dateDeadline;
    dynamic origin;

    //factory Datum.fromJson(String str) => Datum.fromMap(json.decode(str));
    factory Datum.fromJson(Map<String, dynamic> json) => Datum.fromJson(json);

    String toJson() => json.encode(toMap());

    factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        partnerId: json["partner_id"],
        pickingTypeId: json["picking_type_id"],
        locationId: json["location_id"],
        locationDestId: json["location_dest_id"],
        moveLineIds: List<int>.from(json["move_line_ids"].map((x) => x)),
        scheduledDate: DateTime.parse(json["scheduled_date"]),
        dateDeadline: json["date_deadline"],
        origin: json["origin"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "partner_id": partnerId,
        "picking_type_id": pickingTypeId,
        "location_id": locationId,
        "location_dest_id": locationDestId,
        "move_line_ids": List<dynamic>.from(moveLineIds.map((x) => x)),
        "scheduled_date": scheduledDate.toIso8601String(),
        "date_deadline": dateDeadline,
        "origin": origin,
    };
}

class MiniService {
  static Future<List> getData() async {
    final url = Uri.parse('https://iberica-stg-gaston-test-5676747.dev.odoo.com/api/pickings/');

      try {final res = await http.post(url,  
        headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
            'AUTHORIZATION': 'a206a79a-4622-4338-84fe-94f94cbe928e'
          },
          body: json.encode({}));
        if (res.statusCode == 200) {
        final resDecode = json.decode(res.body);
        if (!resDecode['result']['ok']) return [];
        return resDecode;    
      }
      return [];
    } catch (e) {
     print(e);
      return[];
    }
  }
}

