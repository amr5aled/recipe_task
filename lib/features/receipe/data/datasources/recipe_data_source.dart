import '../models/recipe_model.dart';

abstract class RecipeDataSource {
  Future<List<RecipeModel>> getRecipeData();
}
