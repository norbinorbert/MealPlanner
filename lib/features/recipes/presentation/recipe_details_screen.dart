import 'package:material_ui/material_ui.dart';

import '../../../core/colors.dart';
import '../../../core/dimensions.dart';
import '../../../core/typography.dart';
import '../models/recipe.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
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
                      AppDimensions.itemSpacingSmall,
                  left: AppDimensions.itemSpacingMedium,
                  right: AppDimensions.itemSpacingMedium,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _HeroIconButton(
                        icon: Icons.arrow_back,
                        tooltip: 'Back',
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                      _HeroIconButton(
                        icon: Icons.more_horiz,
                        tooltip: 'More options',
                        onPressed: () {},
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
      children: [Image.asset(recipe.imageAssetPath, fit: BoxFit.cover)],
    );
  }
}

class _HeroIconButton extends StatelessWidget {
  const _HeroIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(
        icon,
        size: AppDimensions.iconSizeLarge,
        color: AppColors.content,
      ),
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppDimensions.itemSpacingExtraSmall,
                  children: [
                    Text(recipe.name, style: AppTypography.display),
                    Text(
                      '${recipe.mealType} / ${recipe.prepTimeMinutes} mins',
                      style: AppTypography.bodySmallEmphasis.copyWith(
                        color: AppColors.contentSecondary,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: AppDimensions.itemSpacingMedium,
                  child: IconButton(
                    onPressed: () {},
                    tooltip: 'Reset recipe',
                    icon: const Icon(
                      Icons.refresh,
                      size: AppDimensions.iconSizeLarge,
                    ),
                  ),
                ),
              ],
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
              AppDimensions.itemSpacingExtraLarge,
              AppDimensions.itemSpacing,
              AppDimensions.itemSpacing,
              AppDimensions.itemSpacingSmall,
            ),
            child: Row(
              children: [
                Row(
                  spacing: AppDimensions.itemSpacingSmall,
                  children: [
                    const Text(
                      'Ingredients',
                      style: AppTypography.sectionTitle,
                    ),
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
                AppDimensions.itemSpacingExtraLarge,
                0,
                AppDimensions.itemSpacingLarge,
                AppDimensions.itemSpacingSmall,
              ),
              itemCount: recipe.ingredients.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppDimensions.itemSpacing),
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
              AppDimensions.itemSpacingExtraLarge,
              AppDimensions.itemSpacingMedium,
              AppDimensions.itemSpacingExtraLarge,
              AppDimensions.itemSpacing,
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
                      AppDimensions.cornerRadius,
                    ),
                  ),
                ),
                child: const Text('Start cooking', style: AppTypography.button),
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
        spacing: AppDimensions.itemSpacingExtraSmall,
        children: [
          Text(value, style: AppTypography.bodySmall),
          Text(label, style: AppTypography.bodyEmphasis),
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
