import 'package:material_ui/material_ui.dart';

import '../models/recipe.dart';

class RecipeDetailsScreen extends StatelessWidget {
  const RecipeDetailsScreen({super.key, required this.recipe});

  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  height: constraints.maxHeight * 0.48,
                  child: _RecipeArtwork(recipe: recipe),
                ),
                Positioned(
                  top: MediaQuery.paddingOf(context).top + 8,
                  left: 12,
                  right: 12,
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
                  top: constraints.maxHeight * 0.39,
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
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: recipe.placeholderColors,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (recipe.imageAssetPath case final imageAssetPath?)
            Image.asset(imageAssetPath, fit: BoxFit.cover)
          else
            Center(
              child: Icon(
                recipe.placeholderIcon,
                size: 220,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x1A000000), Colors.transparent],
                stops: [0, 0.3],
              ),
            ),
          ),
        ],
      ),
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
      icon: Icon(icon, size: 28, color: Colors.black),
      style: IconButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.78),
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
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: 86,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${recipe.mealType} / ${recipe.prepTimeMinutes} mins',
                      style: const TextStyle(
                        color: Color(0xFF707070),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 12,
                  child: IconButton(
                    onPressed: () {},
                    tooltip: 'Reset recipe',
                    icon: const Icon(Icons.refresh, size: 28),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 70,
            color: const Color(0xFFF4F4F4),
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
            padding: const EdgeInsets.fromLTRB(24, 14, 18, 8),
            child: Row(
              children: [
                const Text(
                  'Ingredients',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 10),
                Text(
                  '${recipe.servings} serves',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF9A9A9A),
                  ),
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
              padding: const EdgeInsets.fromLTRB(24, 0, 20, 8),
              itemCount: recipe.ingredients.length,
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final ingredient = recipe.ingredients[index];
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        ingredient.name,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                    Text(
                      ingredient.amountLabel,
                      style: const TextStyle(
                        color: Color(0xFFAAAAAA),
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 14),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8A47EB),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  'Start cooking',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
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
        children: [
          Text(value, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
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
      width: 36,
      height: 28,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          padding: EdgeInsets.zero,
          side: const BorderSide(color: Color(0xFF333333)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: icon == Icons.remove
                  ? const Radius.circular(4)
                  : Radius.zero,
              right: icon == Icons.add ? const Radius.circular(4) : Radius.zero,
            ),
          ),
        ),
        child: Icon(icon, size: 18, semanticLabel: tooltip),
      ),
    );
  }
}
