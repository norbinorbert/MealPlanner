import 'package:material_ui/material_ui.dart';

import '../../features/recipes/models/recipe.dart';
import '../../features/recipes/presentation/recipe_details_screen.dart';
import '../theme/colors.dart';
import '../theme/dimensions.dart';
import '../theme/typography.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.recipe,
  });

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(AppDimensions.cornerRadiusMedium),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => RecipeDetailsScreen(recipe: recipe),
            ),
          );
        },
        child: Ink(
          height: AppDimensions.recipeCardHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(recipe.imageAssetPath, fit: BoxFit.cover),
              Positioned(
                left: AppDimensions.contentPadding,
                right: AppDimensions.contentPadding,
                bottom: AppDimensions.itemSpacingLarge,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppDimensions.itemSpacingSmall,
                  children: [
                    Text(
                      recipe.name,
                      style: AppTypography.title.copyWith(
                        color: AppColors.surface,
                      ),
                    ),
                    Text(
                      '${recipe.mealType} · ${recipe.prepTimeMinutes} mins · '
                      '${recipe.nutrition.energyKcal} kcal',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.surface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
