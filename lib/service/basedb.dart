import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:menu_app/models/mealsmodel.dart';

class Store {
  static const String _baseuri = 'www.themealdb.com';
  static const String _path = '/api/json/v1/1/search.php';
  static const List<String> _letters = ['a', 'b', 'c', 'd', 'e', 'f', 'p'];
  static List<MealModel> meals = [];
  static Future<void> getData() async {
    final futures = _letters.map((l) => _get(l));
    final results = await Future.wait(futures);

    meals.addAll(results.expand((list) => list).toList());
    for (final r in meals) {
      r.rating = 1 + Random().nextDouble() * 4;
      r.price = (1 + Random().nextInt(20)).toString();
    }
  }

  static Future<List<MealModel>> _get(String char) async {
    try {
      var uri = Uri.https(_baseuri, _path, {'f': char});
      var response = await http.get(uri);
      if (response.statusCode != 200) {
        return [];
      }
      var dataMap = jsonDecode(response.body) as Map<String, dynamic>;
      final mealsJson = dataMap['meals'] as List<dynamic>;
      return mealsJson.map((m) => MealModel.fromJson(m)).toList();
    } catch (e) {
      return [];
    }
  }
}
