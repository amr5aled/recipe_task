import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_task/features/receipe/domain/entities/recipe.dart';
import 'package:recipe_task/features/receipe/domain/repositories/recipe_repository.dart';
import 'package:recipe_task/features/receipe/domain/usecases/get_recipes_use_case.dart';

class MockRecipeRepository extends Mock implements RecipeRepository {}

void main() {
  group('GetRecipesUseCase', () {
    late GetRecipesUseCase useCase;
    late MockRecipeRepository mockRepository;

    setUp(() {
      mockRepository = MockRecipeRepository();
      useCase = GetRecipesUseCase(mockRepository);
    });

    test('execute should return list of recipes', () async {
      // Mock the behavior of the repository
      when(mockRepository.getRecipes()).thenAnswer((_) async => [
            Recipe(
              name: 'Recipe 1',
              imageUrl: 'url1',
              isFavorite: false,
              id: "1",
              ingredients: [],
              instructions: '',
            ),
            Recipe(
              name: 'Recipe 2',
              imageUrl: 'url2',
              isFavorite: true,
              id: "2",
              ingredients: [],
              instructions: '',
            ),
          ]);

      // Invoke the method on the use case
      final recipes = await useCase.execute();

      // Verify the result
      expect(recipes.length, 2);
      expect(recipes[0].name, 'Recipe 1');
      expect(recipes[1].imageUrl, 'url2');
    });
  });
}
