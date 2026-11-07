import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import 'unit_filter_label.dart';

class UnitFilterDropdown extends StatelessWidget {
  const UnitFilterDropdown({
    super.key,
    required this.label,
    required this.hint,
    required this.onTap,
    required this.onClear,
    this.value,
  });

  final String label;
  final String hint;
  final String? value;
  final VoidCallback onTap;
  final VoidCallback onClear;

  static const _height = 42.0;
  static const _padding = EdgeInsetsDirectional.only(start: 11, end: 4);
  static const _radius = BorderRadius.all(Radius.circular(9));
  static const _clearIconSize = 14.0;
  static const _clearTapSize = 32.0;

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    final value = this.value;
    final hasValue = value != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        UnitFilterLabel(text: label),
        AppSpacing.gapV5,
        Material(
          color: colors.canvas,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: _radius,
            side: BorderSide(color: hasValue ? colors.oceanAccent : colors.subtleBorder),
          ),
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              height: _height,
              child: Padding(
                padding: _padding,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        value ?? hint,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.xxsRegular.copyWith(
                          color: hasValue ? colors.textSecondary : colors.hint,
                        ),
                      ),
                    ),
                    if (hasValue)
                      IconButton(
                        onPressed: onClear,
                        tooltip: MaterialLocalizations.of(context).deleteButtonTooltip,
                        iconSize: _clearIconSize,
                        color: colors.textMuted,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints.tightFor(
                          width: _clearTapSize,
                          height: _clearTapSize,
                        ),
                        icon: const Icon(Icons.close_rounded),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
