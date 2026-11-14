import 'package:material_ui/material_ui.dart';

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
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: _ProgressCard(),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 22, 16, 18),
                itemCount: RecipeRepository.mockRecipes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 18),
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
      height: 94,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xFFE1E1E1),
              child: Icon(Icons.person, color: Color(0xFF777777), size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, size: 30),
              tooltip: 'Menu',
              color: Colors.black,
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
      padding: const EdgeInsets.fromLTRB(18, 19, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF222222)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Today's Progress",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF2477F3),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 32),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View more',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Row(
            children: [
              SizedBox(width: 80, child: _CaloriesAmount()),
              SizedBox(width: 4),
              Expanded(
                child: _MacroProgress(
                  percent: 29,
                  label: 'Fat',
                  color: Color(0xFFFFC42F),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: _MacroProgress(
                  percent: 65,
                  label: 'Pro',
                  color: Color(0xFF3485FF),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: _MacroProgress(
                  percent: 85,
                  label: 'Carb',
                  color: Color(0xFF7772F7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE7E7E7),
                child: Icon(Icons.face_3, size: 24, color: Color(0xFF777777)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 13,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Text(
                    '🎉 Keep the pace! You’re doing great.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
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
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Calories',
          style: TextStyle(fontSize: 14, color: Color(0xFF777777)),
        ),
        SizedBox(height: 5),
        Row(
          children: [
            Icon(Icons.local_fire_department, size: 19),
            SizedBox(width: 2),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  '1,284',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                ),
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
      width: 64,
      height: 68,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: CircularProgressIndicator(
              value: percent / 100,
              strokeWidth: 8,
              strokeCap: StrokeCap.round,
              backgroundColor: const Color(0xFFF1F1F1),
              color: color,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 11, color: Color(0xFF777777)),
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
      borderRadius: BorderRadius.circular(12),
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
          height: 184,
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
                    size: 104,
                    color: Colors.white.withValues(alpha: 0.78),
                  ),
                ),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Color(0xB8000000)],
                    stops: [0.45, 1],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${recipe.mealType} · ${recipe.prepTimeMinutes} mins · '
                      '${recipe.nutrition.energyKcal} kcal',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
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
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
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
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 25, color: Colors.black),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
