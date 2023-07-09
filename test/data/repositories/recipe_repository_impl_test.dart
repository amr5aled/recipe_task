import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_task/features/receipe/data/datasources/recipe_data_source.dart';
import 'package:recipe_task/features/receipe/data/models/recipe_model.dart';
import 'package:recipe_task/features/receipe/data/repositories/recipe_repository_impl.dart';

class MockRecipeDataSource extends Mock implements RecipeDataSource {}

void main() {
  group('RecipeRepositoryImpl', () {
    late RecipeRepositoryImpl repository;
    late MockRecipeDataSource mockDataSource;

    setUp(() {
      mockDataSource = MockRecipeDataSource();
      repository = RecipeRepositoryImpl(mockDataSource);
    });

    test('getRecipes should return list of recipes', () async {
      // Mock the behavior of the data source
      when(mockDataSource.getRecipeData()).thenAnswer((_) async => [
            RecipeModel(
                name: 'Recipe 1', imageUrl: 'url1', isFavorite: false, id: "1"),
            RecipeModel(
                name: 'Recipe 2', imageUrl: 'url2', isFavorite: true, id: "2"),
          ]);

      // Invoke the method on the repository
      final recipes = await repository.getRecipes();

      // Verify the result
      expect(recipes.length, 2);
      expect(recipes[0].name, 'Recipe 1');
      expect(recipes[1].imageUrl, 'url2');
    });
  });
}
