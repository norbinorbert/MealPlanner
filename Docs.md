# Meal Planner Documentation

## Project structure

```text
lib/
  main.dart                          # app entry point and MaterialApp setup
  core/
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
        recipe_repository.dart      # mock recipe data source
      models/
        recipe.dart                 # recipe model and nutrition data
      presentation/
        recipe_details_screen.dart  # detailed recipe screen
assets/
  images/                           # recipe image assets
```

## Reusable widgets

- Toolbar — top header with profile avatar and menu button.
- ProgressCard — summary view for daily calorie intake and macro progress.
- BottomNavigation — row of icon + label navigation items for the main app sections.
- NavigationItem — individual tab in the bottom navigation bar.
- MealPlannerIconButton — standard icon action used in detail screens.
- RecipeCard — clickable recipe tile that shows image, name, type, time, and calories.

## Navigation

`MyApp` starts from `HomeScreen` in `main.dart`, which is the app's default landing view. Each `RecipeCard` navigates to a `RecipeDetailsScreen` using `Navigator.of(context).push(...)`. The app currently uses a straightforward stack-based navigation approach with no named routes.
