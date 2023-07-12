import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_task/features/receipe/domain/entities/recipe.dart';
import 'package:recipe_task/features/receipe/domain/usecases/get_recipes_use_case.dart';
import 'package:recipe_task/features/receipe/presentation/providers/recipe_provider.dart';

class MockGetRecipesUseCase extends Mock implements GetRecipesUseCase {}

class MockHiveBox extends Mock implements Box<bool> {}

void main() {
  group('RecipeProvider', () {
    late RecipeProvider recipeProvider;
    late MockGetRecipesUseCase mockUseCase;
    late MockHiveBox mockHiveBox;

    setUp(() {
      mockUseCase = MockGetRecipesUseCase();
      mockHiveBox = MockHiveBox();
      recipeProvider = RecipeProvider(getRecipesUseCase: mockUseCase);
      Hive.registerAdapter<Recipe>(RecipeAdapter());
    });

    test('fetchRecipes should update recipes list', () async {
      // Mock the behavior of the use case
      when(mockUseCase.execute()).thenAnswer((_) async => [
            Recipe(
              name: 'Recipe 1',
              imageUrl: 'url1',
              isFavorite: false,
              id: '1',
              ingredients: [],
              instructions: '',
            ),
            Recipe(
              name: 'Recipe 2',
              imageUrl: 'url2',
              isFavorite: true,
              id: '2',
              ingredients: [],
              instructions: '',
            ),
          ]);

      // Invoke the method
      await recipeProvider.fetchRecipes();

      // Verify the result
      expect(recipeProvider.recipes.length, 2);
      expect(recipeProvider.recipes[0].name, 'Recipe 1');
      expect(recipeProvider.recipes[1].imageUrl, 'url2');
    });

    test('checkFavouriteRecipe should update isFavorite status', () {
      // Mock the behavior of the Hive box
      when(mockHiveBox.get(any, defaultValue: anyNamed('defaultValue')))
          .thenReturn(true);

      // // Set the Hive box mock
      // Hive.box<bool>(mockHiveBox);

      // Create a sample recipe
      final recipe = Recipe(
        name: 'Recipe 1',
        imageUrl: 'url1',
        isFavorite: false,
        id: '1',
        ingredients: [],
        instructions: '',
      );

      // Invoke the method
      recipeProvider.checkFavouriteRecipe(recipe);

      // Verify the result
      expect(recipeProvider.isFavorite, true);
    });

    test('toggleFavoriteStatus should toggle isFavorite status', () {
      // Mock the behavior of the Hive box
      when(mockHiveBox.get(any, defaultValue: anyNamed('defaultValue')))
          .thenReturn(false);

      // // Set the Hive box mock
      // Hive.registerBox<bool>('favorites', mockHiveBox);

      // Create a sample recipe
      final recipe = Recipe(
        name: 'Recipe 1',
        imageUrl: 'url1',
        isFavorite: false,
        id: '1',
        ingredients: [],
        instructions: '',
      );

      // Invoke the method
      recipeProvider.toggleFavoriteStatus(recipe);

      // Verify the result
      expect(recipeProvider.isFavorite, true);
      verify(mockHiveBox.put(recipe.id, true));
    });
  });
}
