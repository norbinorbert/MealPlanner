import 'package:material_ui/material_ui.dart';

import '../recipes/models/recipe.dart';
import '../recipes/presentation/recipe_details_screen.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/dimensions.dart';
import '../../core/theme/typography.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: AppDimensions.itemSpacingSmall,
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
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.content.withValues(alpha: 0),
                      AppColors.content.withValues(alpha: 0),
                      AppColors.content.withValues(alpha: 0.6),
                    ],
                    stops: [0, 0.45, 1],
                  ),
                ),
              ),
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
                      style: AppTypography.body.copyWith(
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
