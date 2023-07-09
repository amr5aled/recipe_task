import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/recipe.dart';
import '../../domain/usecases/get_recipes_use_case.dart';

class RecipeProvider with ChangeNotifier {
  final GetRecipesUseCase? getRecipesUseCase;
  List<Recipe> _recipes = [];

  RecipeProvider({this.getRecipesUseCase});
  List<Recipe> get recipes => _recipes;
  bool? isFavorite = false;

  void setRecipes(List<Recipe> recipes) {
    _recipes = recipes;
    notifyListeners();
  }

  Future<void> fetchRecipes() async {
    //  await getRecipesUseCase!.execute();
    final url =
        'https://api.npoint.io/43427003d33f1f6b51cc'; // Replace with your API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      _recipes = responseData
          .map((recipeData) => Recipe(
                id: recipeData['id'],
                name: recipeData['name'],
                imageUrl: recipeData['image'],
                ingredients: recipeData['ingredients'].cast<String>(),
                instructions: recipeData['description'],
              ))
          .toList();

      notifyListeners();
    } else {
      throw Exception('Failed to fetch recipes');
    }
  }

  void checkFavouriteRecipe(Recipe recipe) {
    final favoritesBox = Hive.box<bool>('favorites');
    isFavorite = favoritesBox.get(recipe.id, defaultValue: false);
  }

  void toggleFavoriteStatus(Recipe recipe) {
    final favoritesBox = Hive.box<bool>('favorites');
    favoritesBox.put(recipe.id, !isFavorite!);
    isFavorite = !isFavorite!;

    notifyListeners();
  }
}
