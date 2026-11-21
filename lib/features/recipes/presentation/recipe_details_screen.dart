import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/components/meal_planner_icon_button.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/dimensions.dart';
import '../../../core/theme/typography.dart';
import '../models/recipe.dart';
import 'recipe_providers.dart';

class RecipeDetailsScreen extends ConsumerWidget {
  const RecipeDetailsScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(favoriteProvider).value?.contains(recipe.id) ?? false;
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height:
                      constraints.maxHeight *
                      AppDimensions.recipeArtworkHeightFactor,
                  child: _RecipeArtwork(recipe: recipe),
                ),
                Positioned(
                  top:
                      MediaQuery.paddingOf(context).top +
                      AppDimensions.contentPaddingSmall,
                  left: AppDimensions.itemSpacingMedium,
                  right: AppDimensions.itemSpacingMedium,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MealPlannerIconButton(
                        icon: Icons.arrow_back,
                        tooltip: 'Back',
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                      MealPlannerIconButton(
                        icon: isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        tooltip: isFavorite
                            ? 'Remove from favorites'
                            : 'Add to favorites',
                        onPressed: () => ref
                            .read(favoriteProvider.notifier)
                            .toggle(recipe.id),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top:
                      constraints.maxHeight *
                      AppDimensions.recipeSheetTopFactor,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: _RecipeDetailsSheet(recipe: recipe),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _RecipeArtwork extends StatelessWidget {
  const _RecipeArtwork({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        recipe.imageUrl == null
            ? Image.asset(recipe.imageAssetPath, fit: BoxFit.cover)
            : Image.network(
                recipe.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    Image.asset(recipe.imageAssetPath, fit: BoxFit.cover),
              ),
      ],
    );
  }
}

class _RecipeDetailsSheet extends StatelessWidget {
  const _RecipeDetailsSheet({required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    final nutrition = recipe.nutrition;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.cornerRadiusLarge),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: AppDimensions.recipeDetailsHeaderHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.itemSpacingMedium,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    tooltip: 'Reset recipe',
                    icon: const Icon(
                      Icons.refresh,
                      size: AppDimensions.iconSizeLarge,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: AppDimensions.itemSpacingSmall,
                      children: [
                        Text(
                          recipe.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.title,
                        ),
                        Text(
                          '${recipe.mealType} / ${recipe.prepTimeMinutes} mins',
                          style: AppTypography.bodySmallEmphasis.copyWith(
                            color: AppColors.contentSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width:
                        AppDimensions.iconSizeExtraLarge +
                        AppDimensions.itemSpacingLarge,
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: AppDimensions.nutritionRowHeight,
            color: AppColors.surfaceSecondary,
            child: Row(
              children: [
                _NutritionItem(
                  value: '${nutrition.energyKcal} kcal',
                  label: 'Energy',
                ),
                _NutritionItem(
                  value: '${nutrition.proteinGrams} g',
                  label: 'Protein',
                ),
                _NutritionItem(
                  value: '${nutrition.carbohydrateGrams} g',
                  label: 'Carbs',
                ),
                _NutritionItem(value: '${nutrition.fatGrams} g', label: 'Fat'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.contentPaddingLarge,
              AppDimensions.contentPadding,
              AppDimensions.contentPadding,
              AppDimensions.contentPaddingSmall,
            ),
            child: Row(
              children: [
                Row(
                  spacing: AppDimensions.itemSpacing,
                  children: [
                    const Text('Ingredients', style: AppTypography.emphasis),
                    Text(
                      '${recipe.servings} serves',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.contentSecondary,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                _ServingButton(
                  icon: Icons.remove,
                  tooltip: 'Decrease servings',
                ),
                _ServingButton(icon: Icons.add, tooltip: 'Increase servings'),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.contentPaddingLarge,
                0,
                AppDimensions.contentPaddingLarge,
                AppDimensions.contentPaddingSmall,
              ),
              itemCount: recipe.ingredients.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppDimensions.itemSpacingLarge),
              itemBuilder: (context, index) {
                final ingredient = recipe.ingredients[index];
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        ingredient.name,
                        style: AppTypography.bodyLarge,
                      ),
                    ),
                    Text(
                      ingredient.amountLabel,
                      style: AppTypography.body.copyWith(
                        color: AppColors.contentTertiary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.contentPaddingLarge,
              AppDimensions.contentPaddingMedium,
              AppDimensions.contentPaddingLarge,
              AppDimensions.contentPadding,
            ),
            child: SizedBox(
              width: double.infinity,
              height: AppDimensions.cookingButtonHeight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.cornerRadiusSmall,
                    ),
                  ),
                ),
                child: const Text('Start cooking', style: AppTypography.title),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NutritionItem extends StatelessWidget {
  const _NutritionItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppDimensions.itemSpacingSmall,
        children: [
          Text(value, style: AppTypography.bodySmall),
          Text(label, style: AppTypography.emphasis),
        ],
      ),
    );
  }
}

class _ServingButton extends StatelessWidget {
  const _ServingButton({required this.icon, required this.tooltip});

  final IconData icon;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.servingButtonWidth,
      height: AppDimensions.servingButtonHeight,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.content,
          padding: EdgeInsets.zero,
          side: const BorderSide(color: AppColors.content),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: icon == Icons.remove
                  ? const Radius.circular(AppDimensions.cornerRadiusSmall)
                  : Radius.zero,
              right: icon == Icons.add
                  ? const Radius.circular(AppDimensions.cornerRadiusSmall)
                  : Radius.zero,
            ),
          ),
        ),
        child: Icon(
          icon,
          size: AppDimensions.iconSizeSmall,
          semanticLabel: tooltip,
        ),
      ),
    );
  }
}
