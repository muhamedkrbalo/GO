import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class UnitFilterLabel extends StatelessWidget {
  const UnitFilterLabel({super.key, required this.text});

  final String text;

  static const _height = 1.5;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: AppTextStyles.xxxxsBold.copyWith(
        color: context.customColors.formLabel,
        height: _height,
      ),
    );
  }
}
