import 'package:material_ui/material_ui.dart';

import '../theme/colors.dart';
import '../theme/dimensions.dart';

class HeroIconButton extends StatelessWidget {
  const HeroIconButton({
    super.key,
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
      icon: Icon(
        icon,
        size: AppDimensions.iconSizeLarge,
        color: AppColors.content,
      ),
    );
  }
}
