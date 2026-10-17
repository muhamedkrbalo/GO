import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';

enum ToastType { success, error, offline, warning, help }

class CustomToast extends StatelessWidget {
  final ToastType? type;
  final String? title;
  final String? icon;
  final String message;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomToast({
    super.key,
    this.type,
    this.title,
    required this.message,
    this.backgroundColor,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //   width: double.infinity,
      //   height: 50,
      padding: AppPadding.all10,
      margin: AppMargin.all20,
      decoration: BoxDecoration(
        color: backgroundColor ?? _backgroundColor(),
        borderRadius: AppRadius.brCircle,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSpacing.gapH10,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (title != null) ...{
                  Text(
                    title!,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                  ),
                  AppSpacing.gapV8,
                },
                Center(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    // maxLines: 2,
                    // overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _backgroundColor() {
    switch (type) {
      case ToastType.success:
        return const Color(0xff1FC170);
      case ToastType.error:
        return const Color(0xffff3333);
      case ToastType.offline:
        return const Color(0xFF616161);
      case ToastType.warning:
        return const Color(0xffFFCC00);
      case ToastType.help:
        return const Color(0xff0091EA);
      default:
        return const Color(0xff1FC170);
    }
  }
}
