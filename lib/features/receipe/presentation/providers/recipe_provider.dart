import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/recipe.dart';
import '../../domain/usecases/get_recipes_use_case.dart';

class RecipeProvider with ChangeNotifier {
  final GetRecipesUseCase getRecipesUseCase;
  List<Recipe> _recipes = [];

  RecipeProvider({required this.getRecipesUseCase});
  List<Recipe> get recipes => _recipes;
  bool? isFavorite = false;

  void setRecipes(List<Recipe> recipes) {
    _recipes = recipes;
    notifyListeners();
  }

  Future<void> fetchRecipes() async {
    _recipes = await getRecipesUseCase.execute();
    notifyListeners();
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
