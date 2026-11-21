import 'package:material_ui/material_ui.dart';

import '../../core/components/bottom_navigation.dart';
import '../../core/components/toolbar.dart';
import '../../core/components/progress_card.dart';
import 'recipe_card.dart';
import '../../core/theme/dimensions.dart';
import '../recipes/data/recipe_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Toolbar(),
            const SizedBox(height: AppDimensions.contentPadding),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPaddingLarge,
              ),
              child: ProgressCard(),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(
                  AppDimensions.contentPaddingLarge,
                  AppDimensions.contentPaddingLarge,
                  AppDimensions.contentPaddingLarge,
                  AppDimensions.contentPadding,
                ),
                itemCount: RecipeRepository.mockRecipes.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppDimensions.contentPadding),
                itemBuilder: (context, index) =>
                    RecipeCard(recipe: RecipeRepository.mockRecipes[index]),
              ),
            ),
            const BottomNavigation(),
          ],
        ),
      ),
    );
  }
}
