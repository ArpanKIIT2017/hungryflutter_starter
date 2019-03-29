import 'dart:convert';

import 'package:hungryflutter/Models/Category.dart';
import 'package:hungryflutter/Models/Meal.dart';
import 'package:http/http.dart' as http;

class RecipeService {

  static Future<SearchResult> getRecipes(String query) async {
    var response = await http.get('https://www.themealdb.com/api/json/v1/1/search.php?s=$query');
    return SearchResult.fromJson(json.decode(response.body));
  }

  static Future<SearchResult> getRecipesByCategory(String query) async {
    var response = await http.get('https://www.themealdb.com/api/json/v1/1/filter.php?c=$query');
    return SearchResult.fromJson(json.decode(response.body));
  }

  static Future<CategoryList> getCategories() async {
    var response = await http.get('https://www.themealdb.com/api/json/v1/1/categories.php');
    return CategoryList.fromJson(json.decode(response.body));
  }

  static Future<Meal> getMeal(var id) async {
    var response = await http.get('https://www.themealdb.com/api/json/v1/1/lookup.php?i=${id.toString()}');
    return Meal.fromJson(json.decode(response.body)['meals'][0]);
  }

  static Future<SearchResult> getLatestRecipes() async {
    var response = await http.get('https://www.themealdb.com/api/json/v1/1/latest.php');
    return SearchResult.fromJson(json.decode(response.body));
  }

}