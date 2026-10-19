import 'package:flutter/material.dart';

import '../../enum/cubit_state/cubit_status.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_shadows.dart';
import '../../theme/app_sizes.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/extensions/theme_extensions.dart';

class CustomButton extends StatefulWidget {
  final double radius;
  final double? width;
  final double height;
  final TextStyle? style;
  final String? text;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? child;
  final Color? color;
  final Color? borderColor;
  final Gradient? gradient;
  final CubitStatus? cubitState;
  final bool isLoading;
  final bool isMainColor;
  final bool hasShadow;
  final void Function()? onPressed;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color? textColor;
  final Color? loaderColor;
  final bool isEnabled;
  final Color? disabledColor;
  final Color? disabledBorderColor;
  final Color? disabledTextColor;

  const CustomButton({
    super.key,
    this.radius = 14.4,
    this.width,
    this.height = 56,
    this.style,
    this.text,
    this.prefixIcon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.color,
    this.gradient,
    this.cubitState,
    this.isLoading = false,
    this.isMainColor = true,
    this.hasShadow = false,
    this.onPressed,
    this.child,
    this.borderColor,
    this.borderRadius,
    this.boxShadow,
    this.textColor,
    this.loaderColor,
    this.isEnabled = true,
    this.disabledColor,
    this.disabledBorderColor,
    this.disabledTextColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
  }

  Color? get _borderColor => widget.isEnabled
      ? widget.borderColor
      : widget.disabledBorderColor ?? context.customColors.border;

  Color get _textColor => widget.isEnabled
      ? widget.textColor ?? AppColors.white
      : widget.disabledTextColor ?? context.customColors.textMuted;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading || widget.cubitState == CubitStatus.loading
        ? SizedBox(
            height: widget.height,
            child: Center(
              child: CircularProgressIndicator(
                color: widget.loaderColor ?? AppColors.white,
              ),
            ),
          )
        : ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
                width: widget.width ?? double.infinity,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.isEnabled
                      ? widget.color ??
                            (widget.isMainColor
                                ? AppColors.primary
                                : AppColors.secondary)
                      : widget.disabledColor ?? context.customColors.subtleBorder,
                  gradient: widget.isEnabled ? widget.gradient : null,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius),
                  border: _borderColor != null ? Border.all(color: _borderColor!) : null,
                  boxShadow: widget.hasShadow && widget.isEnabled
                      ? widget.boxShadow ?? AppShadows.primaryButton
                      : null,
                ),
                child: ClipRRect(
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap:
                          widget.isLoading ||
                              widget.cubitState == CubitStatus.loading ||
                              widget.isEnabled == false
                          ? null
                          : () {
                              _controller.forward().then((_) {
                                _controller.reverse();
                                widget.onPressed?.call();
                              });
                            },
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (widget.prefixIcon != null) ...{
                              widget.prefixIcon!,
                              AppSpacing.gapH5,
                            },
                            Flexible(
                              child:
                                  widget.child ??
                                  Text(
                                    widget.text ?? '',
                                    textAlign: TextAlign.center,
                                    style:
                                        widget.style ??
                                        AppTextStyles.buttonStyle.copyWith(
                                          color: _textColor,
                                        ),
                                  ),
                            ),
                            if (widget.suffixIcon != null) ...{
                              AppSpacing.gapH5,
                              widget.suffixIcon!,
                            },
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          );
  }
}
