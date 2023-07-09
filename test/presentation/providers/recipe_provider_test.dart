import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_task/features/receipe/domain/entities/recipe.dart';
import 'package:recipe_task/features/receipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_task/features/receipe/domain/usecases/get_recipes_use_case.dart';
import 'package:recipe_task/features/receipe/presentation/providers/recipe_provider.dart';

class MockGetRecipesUseCase extends Mock implements GetRecipesUseCase {}

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  group('RecipeViewModel', () {
    late RecipeProvider viewModel;
    late MockGetRecipesUseCase mockUseCase;
    // late MockRecipeRepository mockRepository;

    setUp(() {
      mockUseCase = MockGetRecipesUseCase();
      // mockRepository = MockRecipeRepository();
      viewModel = RecipeProvider(
        getRecipesUseCase: mockUseCase,
      );
    });

    test('fetchRecipes should update recipes list', () async {
      // Mock the behavior of the use case
      when(mockUseCase.execute()).thenAnswer((_) async => [
            Recipe(
                name: 'Recipe 1', imageUrl: 'url1', isFavorite: false, id: "1"),
            Recipe(
                name: 'Recipe 2', imageUrl: 'url2', isFavorite: false, id: "2"),
          ]);

      // Invoke the method on the view model
      await viewModel.fetchRecipes();

      // Verify the result
      expect(viewModel.recipes.length, 2);
      expect(viewModel.recipes[0].name, 'Recipe 1');
      expect(viewModel.recipes[1].imageUrl, 'url2');
    });
  });
}
