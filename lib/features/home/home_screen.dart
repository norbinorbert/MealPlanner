import 'package:material_ui/material_ui.dart';

import '../../core/colors.dart';
import '../../core/dimensions.dart';
import '../../core/typography.dart';
import '../recipes/data/recipe_repository.dart';
import '../recipes/models/recipe.dart';
import '../recipes/presentation/recipe_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const _HomeToolbar(),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPadding,
              ),
              child: _ProgressCard(),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.contentPadding,
                  AppDimensions.contentPaddingLarge,
                  AppDimensions.contentPadding,
                  AppDimensions.contentPadding,
                ),
                itemCount: RecipeRepository.mockRecipes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimensions.itemSpacingLarge),
                itemBuilder: (context, index) =>
                    _RecipeCard(recipe: RecipeRepository.mockRecipes[index]),
              ),
            ),
            const _HomeNavigation(),
          ],
        ),
      ),
    );
  }
}

class _HomeToolbar extends StatelessWidget {
  const _HomeToolbar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.toolbarHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.contentPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              radius: AppDimensions.iconSizeMedium,
              backgroundColor: AppColors.surfaceSecondary,
              child: Icon(
                Icons.person,
                color: AppColors.contentSecondary,
                size: AppDimensions.iconSizeExtraLarge,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                size: AppDimensions.iconSizeExtraLarge,
              ),
              tooltip: 'Menu',
              color: AppColors.content,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.contentPadding,
        AppDimensions.contentPaddingLarge,
        AppDimensions.contentPadding,
        AppDimensions.contentPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.content),
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadiusMedium),
      ),
      child: Column(
        spacing: AppDimensions.itemSpacingLarge,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text("Today's Progress", style: AppTypography.title),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.action,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(
                    0,
                    AppDimensions.progressButtonHeight,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View more',
                  style: AppTypography.buttonSmall,
                ),
              ),
            ],
          ),
          const Row(
            spacing: AppDimensions.itemSpacingSmall,
            children: [
              SizedBox(
                width: AppDimensions.calorieColumnWidth,
                child: _CaloriesAmount(),
              ),
              Expanded(
                child: _MacroProgress(
                  percent: 29,
                  label: 'Fat',
                  color: AppColors.chartYellow,
                ),
              ),
              Expanded(
                child: _MacroProgress(
                  percent: 65,
                  label: 'Pro',
                  color: AppColors.chartBlue,
                ),
              ),
              Expanded(
                child: _MacroProgress(
                  percent: 85,
                  label: 'Carb',
                  color: AppColors.chartPurple,
                ),
              ),
            ],
          ),
          Row(
            spacing: AppDimensions.itemSpacingMedium,
            children: [
              const CircleAvatar(
                radius: AppDimensions.iconSizeSmall,
                backgroundColor: AppColors.surfaceSecondary,
                child: Icon(
                  Icons.face_3,
                  size: AppDimensions.iconSizeMedium,
                  color: AppColors.contentSecondary,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.contentPaddingMedium,
                    vertical: AppDimensions.contentPaddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.cornerRadiusMedium,
                    ),
                  ),
                  child: const Text(
                    '🎉 Keep the pace! You’re doing great.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CaloriesAmount extends StatelessWidget {
  const _CaloriesAmount();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.itemSpacingSmall,
      children: [
        Text(
          'Calories',
          style: AppTypography.body.copyWith(color: AppColors.contentSecondary),
        ),
        Row(
          spacing: AppDimensions.itemSpacingSmall,
          children: [
            Icon(
              Icons.local_fire_department,
              size: AppDimensions.iconSizeSmall,
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text('1,284', style: AppTypography.metric),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MacroProgress extends StatelessWidget {
  const _MacroProgress({
    required this.percent,
    required this.label,
    required this.color,
  });

  final int percent;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.macroIndicatorSize,
      height: AppDimensions.macroIndicatorHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: AppDimensions.macroIndicatorSize,
            height: AppDimensions.macroIndicatorSize,
            child: CircularProgressIndicator(
              value: percent / 100,
              strokeWidth: AppDimensions.macroIndicatorStrokeWidth,
              strokeCap: StrokeCap.round,
              backgroundColor: AppColors.surfaceSecondary,
              color: color,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$percent%', style: AppTypography.metricCompact),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: AppColors.contentSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.recipe});

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

class _HomeNavigation extends StatelessWidget {
  const _HomeNavigation();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.contentPaddingSmall),
      child: Row(
        children: const [
          _NavigationItem(icon: Icons.wb_sunny_outlined, label: 'Today'),
          _NavigationItem(icon: Icons.restaurant_menu, label: 'Meal Plan'),
          _NavigationItem(
            icon: Icons.shopping_basket_outlined,
            label: 'Grocery List',
          ),
          _NavigationItem(icon: Icons.chat_bubble_outline, label: 'Chat'),
        ],
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.contentPaddingSmall,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: AppDimensions.itemSpacing,
            children: [
              Icon(
                icon,
                size: AppDimensions.iconSizeMedium,
                color: AppColors.content,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(label, style: AppTypography.navigation),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
