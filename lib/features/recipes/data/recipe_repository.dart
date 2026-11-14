import 'package:material_ui/material_ui.dart';

import '../models/recipe.dart';

abstract final class RecipeRepository {
  static const mockRecipes = <Recipe>[
    Recipe(
      id: 'ramen',
      name: 'Ramen',
      mealType: 'Lunch',
      prepTimeMinutes: 15,
      servings: 2,
      nutrition: RecipeNutrition(
        energyKcal: 520,
        proteinGrams: 15,
        carbohydrateGrams: 58,
        fatGrams: 20,
      ),
      ingredients: [
        RecipeIngredient(name: 'Chicken breasts', amount: 250, unit: 'g'),
        RecipeIngredient(name: 'Unsalted butter', amount: 1, unit: 'tbsp'),
        RecipeIngredient(
          name: 'Sesame or vegetable oil',
          amount: 2,
          unit: 'tsp',
        ),
        RecipeIngredient(name: 'Fresh ginger', amount: 2, unit: 'tsp'),
        RecipeIngredient(name: 'Large eggs', amount: 2, unit: 'pcs'),
      ],
      placeholderColors: [
        Color(0xFF4F3423),
        Color(0xFFB36B2B),
        Color(0xFFDD9A40),
      ],
      placeholderIcon: Icons.ramen_dining,
    ),
    Recipe(
      id: 'pepper-skewers',
      name: 'Roasted pepper skewers',
      mealType: 'Dinner',
      prepTimeMinutes: 25,
      servings: 2,
      nutrition: RecipeNutrition(
        energyKcal: 430,
        proteinGrams: 28,
        carbohydrateGrams: 35,
        fatGrams: 18,
      ),
      ingredients: [
        RecipeIngredient(name: 'Chicken breast', amount: 300, unit: 'g'),
        RecipeIngredient(name: 'Red bell pepper', amount: 1, unit: 'pc'),
        RecipeIngredient(name: 'Cherry tomatoes', amount: 120, unit: 'g'),
        RecipeIngredient(name: 'Olive oil', amount: 1, unit: 'tbsp'),
      ],
      placeholderColors: [
        Color(0xFF33483F),
        Color(0xFF8F573B),
        Color(0xFFC17A4A),
      ],
      placeholderIcon: Icons.kebab_dining,
    ),
    Recipe(
      id: 'garden-salad',
      name: 'Green garden salad',
      mealType: 'Lunch',
      prepTimeMinutes: 10,
      servings: 1,
      nutrition: RecipeNutrition(
        energyKcal: 360,
        proteinGrams: 12,
        carbohydrateGrams: 24,
        fatGrams: 22,
      ),
      ingredients: [
        RecipeIngredient(name: 'Baby spinach', amount: 80, unit: 'g'),
        RecipeIngredient(name: 'Avocado', amount: 1, unit: 'pc'),
        RecipeIngredient(name: 'Cucumber', amount: 0.5, unit: 'pc'),
        RecipeIngredient(name: 'Lemon juice', amount: 1, unit: 'tbsp'),
      ],
      placeholderColors: [
        Color(0xFF344A34),
        Color(0xFF5C7C45),
        Color(0xFFB1A34C),
      ],
      placeholderIcon: Icons.eco_outlined,
    ),
  ];
}
