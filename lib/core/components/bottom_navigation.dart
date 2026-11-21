import 'package:material_ui/material_ui.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';
import '../theme/dimensions.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.contentPaddingSmall),
      child: Row(
        children: const [
          NavigationItem(icon: Icons.wb_sunny_outlined, label: 'Today'),
          NavigationItem(icon: Icons.restaurant_menu, label: 'Meal Plan'),
          NavigationItem(
            icon: Icons.shopping_basket_outlined,
            label: 'Grocery List',
          ),
          NavigationItem(icon: Icons.chat_bubble_outline, label: 'Chat'),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({super.key, required this.icon, required this.label});

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
                child: Text(label, style: AppTypography.bodyLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
