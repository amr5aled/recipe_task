import 'package:hive/hive.dart';

part 'recipe.g.dart';
@HiveType(typeId: 0)
class Recipe {
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

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.ingredients,
    this.instructions,
    this.isFavorite = false,
  });
}
