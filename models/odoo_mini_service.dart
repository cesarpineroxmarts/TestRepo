import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/Picking_model.dart';
import '../utils/helpers.dart';

class OdooMiniService {
  static Future<List> getPickings () async {
    try {final url = Uri.parse('https://xmarts.cnemo.dev/api/pickings/');
    final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
            'AUTHORIZATION': 'a206a79a-4622-4338-84fe-94f94cbe928e',
          },
          body: json.encode({}));
    if (res.statusCode == 200) {
    final resDecode = json.decode(res.body);
    if (!resDecode['result']['ok']) return [];
    final responseClear = clearData(resDecode['result']['data']);
    return responseClear;
  } return [];
    }  catch (e) {
    print('Error en el metodo call de Nuevo');
    print(e);
    return [];
    }
  }

   static Future<List> getMoveLine () async {
    try {final url = Uri.parse('https://xmarts.cnemo.dev/api/stockmovelines/');
    final res = await http.post(url,
          headers: {
            'Content-Type': 'application/json;charset=UTF-8',
            'Charset': 'utf-8',
            'AUTHORIZATION': 'a206a79a-4622-4338-84fe-94f94cbe928e',
          },
          body: json.encode({}));
    if (res.statusCode == 200) {
    final resDecode = json.decode(res.body);
    if (!resDecode['result']['ok']) return [];
    final responseClear = clearData(resDecode['result']['data']);
    return responseClear;
  } return [];
    }  catch (e) {
    print('Error en el metodo getMoveLine');
    print(e);
    return [];
    }
  }
}