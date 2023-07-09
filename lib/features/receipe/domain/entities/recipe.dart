class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final List<String>? ingredients;
  final String? instructions;

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
