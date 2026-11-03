import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/custom_widgets/custom_switch/custom_switch.dart';
import '../../../../../core/locale/app_locale_key.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class PrimaryAddressToggle extends StatelessWidget {
  const PrimaryAddressToggle({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  static const _minHeight = 54.0;
  static const _gap = 12.0;
  static const _textGap = 3.0;
  static const _titleHeight = 1.5;
  static const _subtitleHeight = 1.35;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;

    return MergeSemantics(
      child: InkWell(
        onTap: () => onChanged(!value),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: _minHeight),
          child: Row(
            children: [
              CustomSwitch(value: value, onChanged: onChanged),
              const SizedBox(width: _gap),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.setAsPrimaryAddress.tr(),
                      style: AppTextStyles.xxsBold.copyWith(
                        color: colors.textSecondary,
                        height: _titleHeight,
                      ),
                    ),
                    const SizedBox(height: _textGap),
                    Text(
                      AppLocaleKey.primaryAddressDescription.tr(),
                      style: AppTextStyles.xxxxsRegular.copyWith(
                        color: colors.textMuted,
                        height: _subtitleHeight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
