import 'package:dio/dio.dart';

import '../models/recipe.dart';
import 'recipe_dto.dart';

class RecipeRepository {
  const RecipeRepository(this._dio);

  final Dio _dio;

  Future<List<Recipe>> fetchRecipes() async {
    final response = await _dio.get<Map<String, dynamic>>(
      'search.php',
      queryParameters: {'f': 'a'},
    );
    final meals = response.data?['meals'];
    if (meals is! List) {
      return [];
    }

    return meals
        .whereType<Map>()
        .map((json) => RecipeDto.fromJson(json.cast<String, dynamic>()))
        .where((dto) => dto.isValid)
        .map(_toDomain)
        .toList();
  }

  Future<Recipe?> fetchRecipe(String id) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'lookup.php',
      queryParameters: {'i': id},
    );
    final meals = response.data?['meals'];
    if (meals is! List || meals.isEmpty) {
      return null;
    }
    final dto = RecipeDto.fromJson(meals.first.cast<String, dynamic>());
    return dto.isValid ? _toDomain(dto) : null;
  }

  Recipe _toDomain(RecipeDto dto) {
    final ingredients = dto.ingredients.entries
        .map((entry) => _toIngredient(entry.key, entry.value))
        .toList();
    final category = dto.category?.trim();
    final area = dto.area?.trim();
    final mealType = [
      if (category != null && category.isNotEmpty) category,
      if (area != null && area.isNotEmpty) area,
    ].join(' / ');

    return Recipe(
      id: dto.id,
      name: dto.name,
      mealType: mealType.isEmpty ? 'Recipe' : mealType,
      prepTimeMinutes: 30,
      servings: 2,
      nutrition: const RecipeNutrition(
        energyKcal: 0,
        proteinGrams: 0,
        carbohydrateGrams: 0,
        fatGrams: 0,
      ),
      ingredients: ingredients,
      imageAssetPath: 'assets/images/placeholder.jpg',
      imageUrl: dto.imageUrl,
      instructions: dto.instructions ?? '',
      sourceUrl: dto.sourceUrl,
      youtubeUrl: dto.youtubeUrl,
    );
  }

  RecipeIngredient _toIngredient(String name, String measure) {
    final match = RegExp(r'^([\d./]+\s*)?(.*)$').firstMatch(measure);
    final amountText = match?.group(1)?.trim() ?? '';
    final unit = match?.group(2)?.trim() ?? '';
    final amount = _parseAmount(amountText);
    return RecipeIngredient(name: name, amount: amount, unit: unit);
  }

  double _parseAmount(String value) {
    if (value.isEmpty) {
      return 0;
    }
    if (value.contains('/') && !value.contains(' ')) {
      final parts = value.split('/');
      if (parts.length == 2) {
        final numerator = double.tryParse(parts[0]);
        final denominator = double.tryParse(parts[1]);
        if (numerator != null && denominator != null && denominator != 0) {
          return numerator / denominator;
        }
      }
    }
    return double.tryParse(value) ?? 0;
  }
}
