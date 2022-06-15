import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/filtros_response.dart';

class FiltrosProviders extends ChangeNotifier {
  List<Filtro> filtros = [];
  FiltrosProviders() {
    getFiltros();
  }

  Future<List<Filtro>> getFiltros() async {
    final url =
        Uri.parse("http://10.0.2.2:3001/api/modules/actibarrio/traerFiltros");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      final jsonResult = FiltrosResponse.fromJson(data);
      filtros = jsonResult.results;
      print(filtros);
      notifyListeners();
    }
    return filtros;
  }
}
