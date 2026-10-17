import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/images/app_images.dart';
import 'package:flutter_hr_erb/core/theme/app_sizes.dart';
import 'package:lottie/lottie.dart';
import '../../enum/cubit_state/cubit_status.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading || widget.cubitState == CubitStatus.loading
        ? Center(
            child: CircularProgressIndicator(
              color: widget.loaderColor ?? AppColors.white,
            ),
          )
        : ScaleTransition(
            scale: _scaleAnimation,
            child: ClipRRect(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius),
              child: Container(
                width: widget.width ?? double.infinity,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.isEnabled
                      ? widget.color ??
                            (widget.isMainColor
                                ? AppColors.primary
                                : AppColors.secondary)
                      : AppColors.primary.withValues(alpha: 0.4),
                  gradient: widget.isEnabled ? widget.gradient : null,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(widget.radius),
                  border: widget.borderColor != null
                      ? Border.all(color: widget.borderColor!)
                      : null,
                  boxShadow: widget.hasShadow
                      ? widget.boxShadow ??
                            [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                offset: const Offset(0, 0),
                                blurRadius: 6,
                              ),
                            ]
                      : null,
                ),
                child: Center(
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
                                    widget.text ?? "",
                                    textAlign: TextAlign.center,
                                    style:
                                        widget.style ??
                                        AppTextStyles.buttonStyle.copyWith(
                                          color:
                                              widget.textColor ?? AppColors.white,
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
            ),
          );
  }
}
