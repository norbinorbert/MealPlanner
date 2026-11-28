import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../recipes/models/recipe.dart';
import '../recipes/presentation/recipe_details_screen.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/dimensions.dart';
import '../../core/theme/typography.dart';
import '../recipes/presentation/recipe_providers.dart';

class RecipeCard extends ConsumerWidget {
  const RecipeCard({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(favoriteProvider).value?.contains(recipe.id) ?? false;
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
              recipe.imageUrl == null
                  ? Image.asset(recipe.imageAssetPath, fit: BoxFit.cover)
                  : Image.network(
                      recipe.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Image.asset(recipe.imageAssetPath, fit: BoxFit.cover),
                    ),
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
                top: AppDimensions.itemSpacingMedium,
                right: AppDimensions.itemSpacingMedium,
                child: Material(
                  color: AppColors.surface.withValues(alpha: 0.9),
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: IconButton(
                    tooltip: isFavorite
                        ? 'Remove from favorites'
                        : 'Add to favorites',
                    onPressed: () =>
                        ref.read(favoriteProvider.notifier).toggle(recipe.id),
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? AppColors.accent : AppColors.content,
                    ),
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
