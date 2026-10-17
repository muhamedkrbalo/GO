import 'package:flutter/material.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';


extension OnTapScaleAnimation on Widget {
  Widget onTapScaleAnimation({
    required VoidCallback onTap,
    Duration duration = const Duration(milliseconds: 200),
    double scale = 0.8,
  }) {
    return _TapScaleAnimatedWidget(
      onTap: onTap,
      duration: duration,
      scale: scale,
      child: this,
    );
  }
}

class _TapScaleAnimatedWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final Duration duration;
  final double scale;

  const _TapScaleAnimatedWidget({
    required this.child,
    required this.onTap,
    required this.duration,
    required this.scale,
  });

  @override
  State<_TapScaleAnimatedWidget> createState() =>
      _TapScaleAnimatedWidgetState();
}

class _TapScaleAnimatedWidgetState extends State<_TapScaleAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scale,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller
        .forward()
        .then((_) => _controller.reverse())
        .then((_) => widget.onTap());
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      splashColor: AppColors.primary.withValues(alpha: 0.2),
      highlightColor: AppColors.primary.withValues(alpha: 0.1),
      onTap: _handleTap,
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}
