import 'package:hive/hive.dart';

part 'recipe_model.g.dart';
@HiveType(typeId: 0)
class RecipeModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String imageUrl;
  final List<String>? ingredients;
  final String? instructions;
  @HiveField(3)
  bool isFavorite;

  RecipeModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.ingredients,
    this.instructions,
    this.isFavorite = false,
  });
}
