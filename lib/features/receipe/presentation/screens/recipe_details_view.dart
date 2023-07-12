import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/recipe.dart';
import '../providers/recipe_provider.dart';


class RecipeDetailsScreen extends StatefulWidget {
  final Recipe recipe;

  RecipeDetailsScreen({required this.recipe});

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  void initState() {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    recipeProvider.checkFavouriteRecipe(widget.recipe);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.recipe.imageUrl),
              SizedBox(height: 16),
              Text(
                'Ingredients:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              for (final ingredient in widget.recipe.ingredients!)
                Text('- $ingredient'),
              SizedBox(height: 16),
              Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(widget.recipe.instructions!),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      recipeProvider.toggleFavoriteStatus(widget.recipe);
                    },
                    icon: Icon(
                      recipeProvider.isFavorite!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
