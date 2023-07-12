import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../core/constant.dart';
import '../models/recipe_model.dart';

abstract class RecipeDataSource {
  Future<List<RecipeModel>> getRecipeData();
}

class RecipeRemoteDataImpl implements RecipeDataSource {
  @override
  Future<List<RecipeModel>> getRecipeData() async {
    final url = AppConstants.apiUrl; // Replace with your API endpoint
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      return responseData
          .map((recipeData) => RecipeModel(
                id: recipeData['id'],
                name: recipeData['name'],
                imageUrl: recipeData['image'],
                ingredients: recipeData['ingredients'].cast<String>(),
                instructions: recipeData['description'],
              ))
          .toList();
    } else {
      return [];
    }
  }
}
