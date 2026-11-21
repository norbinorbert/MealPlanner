class RecipeDto {
  const RecipeDto({
    required this.id,
    required this.name,
    this.category,
    this.area,
    this.instructions,
    this.imageUrl,
    this.sourceUrl,
    this.youtubeUrl,
    this.ingredients = const {},
  });

  factory RecipeDto.fromJson(Map<String, dynamic> json) {
    final ingredients = <String, String>{};
    for (var index = 1; index <= 20; index++) {
      final ingredient = (json['strIngredient$index'] as String? ?? '').trim();
      if (ingredient.isEmpty) {
        continue;
      }
      final measure = (json['strMeasure$index'] as String? ?? '').trim();
      ingredients[ingredient] = measure;
    }

    return RecipeDto(
      id: (json['idMeal'] as String? ?? '').trim(),
      name: (json['strMeal'] as String? ?? '').trim(),
      category: (json['strCategory'] as String?)?.trim(),
      area: (json['strArea'] as String?)?.trim(),
      instructions: (json['strInstructions'] as String?)?.trim(),
      imageUrl: (json['strMealThumb'] as String?)?.trim(),
      sourceUrl: (json['strSource'] as String?)?.trim(),
      youtubeUrl: (json['strYoutube'] as String?)?.trim(),
      ingredients: ingredients,
    );
  }

  final String id;
  final String name;
  final String? category;
  final String? area;
  final String? instructions;
  final String? imageUrl;
  final String? sourceUrl;
  final String? youtubeUrl;
  final Map<String, String> ingredients;

  bool get isValid => id.isNotEmpty && name.isNotEmpty;
}
