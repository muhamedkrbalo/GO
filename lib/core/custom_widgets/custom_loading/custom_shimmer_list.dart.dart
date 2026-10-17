import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CustomShimmerList extends StatelessWidget {
  const CustomShimmerList({
    super.key,
    this.width = 130,
    this.height = 25,
    this.radius = 10,
    this.shimmerColor = Colors.white12,
    this.fillColor = const Color(0xFFEEEEEE),
    this.duration = const Duration(milliseconds: 1200),
    this.padding,
    this.length,
    this.isVertical,
    this.margin,
  });

  final double? width;
  final double height;
  final double radius;
  final Color shimmerColor;
  final Color fillColor;
  final Duration duration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final int? length;
  final bool? isVertical;

  @override
  Widget build(BuildContext context) {
    return isVertical == true
        ? SingleChildScrollView(
            child: Column(
              children: _buildShimmerList(
                padding ?? const EdgeInsetsDirectional.only(start: 0, bottom: 10, end: 0, top: 0),
              ),
            ),
          )
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: _buildShimmerList(padding)),
          );
  }

  List<Widget> _buildShimmerList(EdgeInsetsGeometry? padding) {
    return List.generate(
      length ?? 5,
      (index) => Container(
        padding: padding,
        width: width,
        margin: margin,
        child: Shimmer(
          color: shimmerColor,
          duration: duration,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),
      ),
    );
  }
}
