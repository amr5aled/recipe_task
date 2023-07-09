import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../datasources/recipe_data_source.dart';
import '../models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeDataSource dataSource;

  RecipeRepositoryImpl(this.dataSource);

  @override
  Future<List<Recipe>> getRecipes() async {
    final recipeModels = await dataSource.getRecipeData();
    return recipeModels.map((model) => _mapToDomain(model)).toList();
  }

  Recipe _mapToDomain(RecipeModel model) {
    return Recipe(
      name: model.name,
      imageUrl: model.imageUrl,
      isFavorite: model.isFavorite,
      id: model.id,
    );
  }
}
