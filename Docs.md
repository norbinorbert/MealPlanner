# Meal Planner Documentation

## Project structure

```text
lib/
  main.dart                          # app entry point and MaterialApp setup
  core/
    network/
      dio_client.dart               # central TheMealDB HTTP client configuration
    components/
      bottom_navigation.dart        # bottom tab navigation UI
      toolbar.dart                  # top toolbar with profile/avatar and menu
      progress_card.dart            # calories and macro progress summary card
      meal_planner_icon_button.dart # reusable circular icon action button
    theme/
      colors.dart                   # app color palette
      dimensions.dart               # spacing and size constants
      typography.dart               # shared text styles
  features/
    home/
      home_screen.dart              # main home screen composition
      recipe_card.dart              # tappable recipe card widget
    recipes/
      data/
        recipe_dto.dart             # API JSON representation
        recipe_repository.dart      # TheMealDB API access and DTO-to-domain mapping
      models/
        recipe.dart                 # recipe model and nutrition data
      presentation/
        recipe_details_screen.dart  # detailed recipe screen
        recipe_providers.dart       # Riverpod recipe and favorite state
assets/
  images/                           # recipe image assets
```

## State and data flow

The app uses Riverpod for dependency injection and shared state. `RecipeRepository`
loads recipes from TheMealDB through a centrally configured Dio client.
`RecipeDto` validates and maps API JSON fields before they are converted into
the immutable `Recipe` domain model used by the UI.

The home screen exposes the repository result through `recipeListProvider` and
handles loading, success, empty, error, and retry states. Shared favorite recipe
IDs are managed by `favoriteProvider`, keeping the home and details screens in sync.

## API integration

The app uses the development API key `1` and the TheMealDB search endpoint:

```text
https://www.themealdb.com/api/json/v1/1/search.php?f=a
```

Recipe thumbnails are loaded from the URL returned by the API. Asset images remain
as fallbacks for unavailable network images. Recipe data and imagery should be
credited to TheMealDB.

## Persistent favorites

Favorite recipe IDs are stored in `SharedPreferences` under
`favorite_recipe_ids`. The provider loads this persisted set on startup and
writes updates whenever a favorite is added or removed. Therefore, favorites
remain available after an application restart.

## Reusable widgets

- Toolbar — top header with profile avatar and menu button.
- ProgressCard — summary view for daily calorie intake and macro progress.
- BottomNavigation — row of icon + label navigation items for the main app sections.
- NavigationItem — individual tab in the bottom navigation bar.
- MealPlannerIconButton — standard icon action used in detail screens.
- RecipeCard — clickable recipe tile that shows image, name, type, time, calories,
  and a favorite toggle.

## Navigation

`MyApp` initializes Riverpod with `ProviderScope` and starts from `HomeScreen` in
`main.dart`. Each `RecipeCard` navigates to `RecipeDetailsScreen` using
`Navigator.of(context).push(...)`. The app uses a straightforward stack-based
navigation approach with no named routes.
