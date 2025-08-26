import 'dart:math';

import 'package:menu_app/models/mealsmodel.dart';

List<CurrentBasketModel> currentItems = [];

class CurrentBasketModel {
  int id = 0;
  final int itemNo;
  final MealModel meal;
  final int itemPrice = 0;
  CurrentBasketModel({required this.itemNo, required this.meal}) {
    meal.price = (int.parse(meal.price!) * itemNo).toString();
    id = Random().nextInt(2000);
  }
}
