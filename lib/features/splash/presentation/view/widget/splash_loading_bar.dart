import 'package:flutter/material.dart';

import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';

class SplashLoadingBar extends StatefulWidget {
  const SplashLoadingBar({super.key});

  @override
  State<SplashLoadingBar> createState() => _SplashLoadingBarState();
}

class _SplashLoadingBarState extends State<SplashLoadingBar> with SingleTickerProviderStateMixin {
  static const _trackWidth = 72.0;
  static const _segmentWidth = 30.0;
  static const _height = 2.0;
  static const _trackOpacity = 0.1;
  static const _duration = Duration(milliseconds: 1200);

  late final AnimationController _controller;
  late final Animation<double> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration)..repeat();
    _offset = Tween<double>(
      begin: -_segmentWidth,
      end: _trackWidth,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.customColors;
    return ClipRRect(
      borderRadius: AppRadius.brCircle,
      child: Container(
        width: _trackWidth,
        height: _height,
        color: colors.primary.withValues(alpha: _trackOpacity),
        child: AnimatedBuilder(
          animation: _offset,
          builder: (context, child) => Stack(
            children: [PositionedDirectional(start: _offset.value, child: child!)],
          ),
          child: Container(
            width: _segmentWidth,
            height: _height,
            decoration: BoxDecoration(
              borderRadius: AppRadius.brCircle,
              gradient: LinearGradient(colors: [colors.highlight, colors.goldAccent]),
            ),
          ),
        ),
      ),
    );
  }
}
