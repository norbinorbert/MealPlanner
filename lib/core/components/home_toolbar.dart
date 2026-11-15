import 'package:material_ui/material_ui.dart';

import '../theme/colors.dart';
import '../theme/dimensions.dart';

class HomeToolbar extends StatelessWidget {
  const HomeToolbar({super.key});

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
