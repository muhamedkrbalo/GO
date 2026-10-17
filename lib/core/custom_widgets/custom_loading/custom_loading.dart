import 'package:flutter_hr_erb/core/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


// class CustomLoading extends StatelessWidget {
//   final double size;
//   final Color? color;
//   const CustomLoading({
//     super.key,
//     this.size = 35,
//     this.color,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LoadingAnimationWidget.discreteCircle(
//       color: color ?? AppColors.primary,
//       secondRingColor: color ?? AppColors.primary,
//       thirdRingColor: color ?? AppColors.primary,
//       size: size,
//     );
//   }
// }
class CustomLoading extends StatelessWidget {
  final double size;
  final Color? color;
  const CustomLoading({super.key, this.size = 30, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).primaryColor,
        strokeWidth: 3.0,
      ),
    );
  }
}
