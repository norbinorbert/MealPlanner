import 'package:material_ui/material_ui.dart';

import '../../core/components/home_navigation.dart';
import '../../core/components/home_toolbar.dart';
import '../../core/components/progress_card.dart';
import '../../core/components/recipe_card.dart';
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
            const HomeToolbar(),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.contentPadding,
              ),
              child: ProgressCard(),
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
                    RecipeCard(recipe: RecipeRepository.mockRecipes[index]),
              ),
            ),
            const HomeNavigation(),
          ],
        ),
      ),
    );
  }
}
