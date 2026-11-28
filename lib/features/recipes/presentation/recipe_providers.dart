import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/dio_client.dart';
import '../data/recipe_repository.dart';
import '../models/recipe.dart';

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

final recipeRepositoryProvider = Provider<RecipeRepository>((ref) {
  return RecipeRepository(ref.watch(dioClientProvider).dio);
});

class RecipeListNotifier extends AsyncNotifier<List<Recipe>> {
  @override
  Future<List<Recipe>> build() {
    return ref.read(recipeRepositoryProvider).fetchRecipes();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(recipeRepositoryProvider).fetchRecipes(),
    );
  }
}

final recipeListProvider =
    AsyncNotifierProvider<RecipeListNotifier, List<Recipe>>(
      RecipeListNotifier.new,
    );

final favoritePreferencesProvider = FutureProvider<SharedPreferences>(
  (ref) => SharedPreferences.getInstance(),
);

class FavoriteNotifier extends AsyncNotifier<Set<String>> {
  static const _storageKey = 'favorite_recipe_ids';

  @override
  Future<Set<String>> build() async {
    final preferences = await ref.watch(favoritePreferencesProvider.future);
    return preferences.getStringList(_storageKey)?.toSet() ?? <String>{};
  }

  Future<void> toggle(String recipeId) async {
    final current = state.value ?? <String>{};
    final next = Set<String>.from(current);
    if (next.contains(recipeId)) {
      next.remove(recipeId);
    } else {
      next.add(recipeId);
    }

    state = AsyncData(next);
    final preferences = await ref.read(favoritePreferencesProvider.future);
    await preferences.setStringList(_storageKey, next.toList());
  }

  bool isFavorite(String recipeId) => state.value?.contains(recipeId) ?? false;
}

final favoriteProvider = AsyncNotifierProvider<FavoriteNotifier, Set<String>>(
  FavoriteNotifier.new,
);
