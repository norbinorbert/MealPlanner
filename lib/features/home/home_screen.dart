import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/components/bottom_navigation.dart';
import '../../core/components/toolbar.dart';
import '../../core/components/progress_card.dart';
import 'recipe_card.dart';
import '../../core/theme/dimensions.dart';
import '../recipes/presentation/recipe_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipes = ref.watch(recipeListProvider);
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
              child: recipes.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      AppDimensions.contentPaddingLarge,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Could not load recipes.',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppDimensions.contentPadding),
                        ElevatedButton(
                          onPressed: () =>
                              ref.read(recipeListProvider.notifier).refresh(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                ),
                data: (recipeList) {
                  if (recipeList.isEmpty) {
                    return const Center(child: Text('No recipes found.'));
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.contentPaddingLarge,
                      AppDimensions.contentPaddingLarge,
                      AppDimensions.contentPaddingLarge,
                      AppDimensions.contentPadding,
                    ),
                    itemCount: recipeList.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: AppDimensions.contentPadding),
                    itemBuilder: (context, index) =>
                        RecipeCard(recipe: recipeList[index]),
                  );
                },
              ),
            ),
            const BottomNavigation(),
          ],
        ),
      ),
    );
  }
}
