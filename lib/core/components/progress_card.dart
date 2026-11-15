import 'package:material_ui/material_ui.dart';

import '../theme/colors.dart';
import '../theme/dimensions.dart';
import '../theme/typography.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.contentPadding,
        AppDimensions.contentPaddingLarge,
        AppDimensions.contentPadding,
        AppDimensions.contentPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.content),
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadiusMedium),
      ),
      child: Column(
        spacing: AppDimensions.itemSpacingLarge,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text("Today's Progress", style: AppTypography.title),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.action,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(
                    0,
                    AppDimensions.progressButtonHeight,
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('View more', style: AppTypography.emphasis),
              ),
            ],
          ),
          const Row(
            spacing: AppDimensions.itemSpacingSmall,
            children: [
              SizedBox(
                width: AppDimensions.calorieColumnWidth,
                child: CaloriesAmount(calories: 1284),
              ),
              Expanded(
                child: MacroProgress(
                  percent: 29,
                  label: 'Fat',
                  color: AppColors.chartYellow,
                ),
              ),
              Expanded(
                child: MacroProgress(
                  percent: 65,
                  label: 'Pro',
                  color: AppColors.chartBlue,
                ),
              ),
              Expanded(
                child: MacroProgress(
                  percent: 85,
                  label: 'Carb',
                  color: AppColors.chartPurple,
                ),
              ),
            ],
          ),
          Row(
            spacing: AppDimensions.itemSpacingMedium,
            children: [
              const CircleAvatar(
                radius: AppDimensions.iconSizeSmall,
                backgroundColor: AppColors.surfaceSecondary,
                child: Icon(
                  Icons.face_3,
                  size: AppDimensions.iconSizeMedium,
                  color: AppColors.contentSecondary,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.contentPaddingMedium,
                    vertical: AppDimensions.contentPaddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSecondary,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.cornerRadiusMedium,
                    ),
                  ),
                  child: const Text(
                    '🎉 Keep the pace! You’re doing great.',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.body,
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

class CaloriesAmount extends StatelessWidget {
  const CaloriesAmount({super.key, required this.calories});

  final int calories;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppDimensions.itemSpacingSmall,
      children: [
        Text(
          'Calories',
          style: AppTypography.body.copyWith(color: AppColors.contentSecondary),
        ),
        Row(
          spacing: AppDimensions.itemSpacingSmall,
          children: [
            Icon(
              Icons.local_fire_department,
              size: AppDimensions.iconSizeSmall,
            ),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(calories.toString(), style: AppTypography.title),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MacroProgress extends StatelessWidget {
  const MacroProgress({
    super.key,
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
      width: AppDimensions.macroIndicatorSize,
      height: AppDimensions.macroIndicatorHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: AppDimensions.macroIndicatorSize,
            height: AppDimensions.macroIndicatorSize,
            child: CircularProgressIndicator(
              value: percent / 100,
              strokeWidth: AppDimensions.macroIndicatorStrokeWidth,
              strokeCap: StrokeCap.round,
              backgroundColor: AppColors.surfaceSecondary,
              color: color,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$percent%', style: AppTypography.emphasis),
              Text(
                label,
                style: AppTypography.caption.copyWith(
                  color: AppColors.contentSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
