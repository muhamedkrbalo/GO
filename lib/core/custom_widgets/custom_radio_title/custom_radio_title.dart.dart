import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

class RadioOptions {
  final String value;
  final String labelKey;
  const RadioOptions(this.value, this.labelKey);
}

class CustomRadioTitle extends StatelessWidget {
  final RadioOptions option;
  final ValueNotifier<String> selectedNotifier;
  final VoidCallback? onTap;
  const CustomRadioTitle({
    super.key,
    required this.option,
    required this.selectedNotifier,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: selectedNotifier,
      builder: (context, selected, _) {
        final bool isActive = selected == option.value;
        final Color borderColor = isActive
            ? AppColors.primary
            : context.customColors.lightGrey;
        return InkWell(
          onTap: () {
            selectedNotifier.value = option.value;
            onTap?.call();
          },
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: AppPadding.v10,
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: context.customColors.surface,
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 2),
                  ),
                  child: AnimatedOpacity(
                    opacity: isActive ? 1 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: const Padding(
                      padding: EdgeInsets.all(3),
                      child: CircleAvatar(backgroundColor: AppColors.primary),
                    ),
                  ),
                ),
                AppSpacing.gapH8,
                Expanded(
                  child: Text(option.labelKey.tr(), style: AppTextStyles.mRegular.copyWith(color: context.customColors.textSecondary)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
