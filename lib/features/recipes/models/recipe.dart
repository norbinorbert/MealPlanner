class Recipe {
  const Recipe({
    required this.id,
    required this.name,
    required this.mealType,
    required this.prepTimeMinutes,
    required this.servings,
    required this.nutrition,
    required this.ingredients,
    required this.imageAssetPath,
  });

  final String id;
  final String name;
  final String mealType;
  final int prepTimeMinutes;
  final int servings;
  final RecipeNutrition nutrition;
  final List<RecipeIngredient> ingredients;
  final String imageAssetPath;
}

class RecipeNutrition {
  const RecipeNutrition({
    required this.energyKcal,
    required this.proteinGrams,
    required this.carbohydrateGrams,
    required this.fatGrams,
  });

  final int energyKcal;
  final int proteinGrams;
  final int carbohydrateGrams;
  final int fatGrams;
}

class RecipeIngredient {
  const RecipeIngredient({
    required this.name,
    required this.amount,
    required this.unit,
  });

  final String name;
  final double amount;
  final String unit;

  String get amountLabel {
    final amountText = amount == amount.roundToDouble()
        ? amount.toInt().toString()
        : amount.toString();
    return '$amountText $unit';
  }
}
