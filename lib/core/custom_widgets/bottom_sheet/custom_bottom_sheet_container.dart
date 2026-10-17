import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/extensions/theme_extensions.dart';


class CustomBottomSheetContainer extends StatefulWidget {
  const CustomBottomSheetContainer({super.key, this.headerText, required this.content});

  final String? headerText;
  final Widget content;
  @override
  State<CustomBottomSheetContainer> createState() => _CustomBottomSheetContainerState();
}

class _CustomBottomSheetContainerState extends State<CustomBottomSheetContainer> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsetsDirectional.only(
          start: 20,
          end: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom == 0
              ? 16
              : MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AppSpacing.gapV15,
            Center(
              child: SizedBox(
                width: 30,
                child: Divider(color: context.customColors.lightGrey, thickness: 2),
              ),
            ),
            AppSpacing.gapV24,
            Text(widget.headerText ?? '', style: AppTextStyles.mMedium.copyWith(color: context.customColors.textSecondary)),
            widget.content,
          ],
        ),
      ),
    );
  }
}
