import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recipe_provider.dart';
import '../../domain/entities/recipe.dart';
import 'recipe_details_view.dart';

class RecipeListScreen extends StatefulWidget {
  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final List<Recipe> recipes = recipeProvider.recipes;

    return Scaffold(
      appBar: AppBar(title: Text('Recipes')),
      body: ListView.separated(
        padding: EdgeInsets.all(20),
        itemCount: recipes.length,
        itemBuilder: (ctx, index) => ListTile(
          leading: Image.network(recipes[index].imageUrl),
          title: Text(recipes[index].name),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => RecipeDetailsScreen(recipe: recipes[index]),
              ),
            );
          },
        ),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 20,
        ),
      ),
    );
  }
}
