// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../images/app_images.dart';

// class CustomRatingBar extends StatefulWidget {
//   const CustomRatingBar({
//     super.key,
//     this.itemSize,
//     this.allowHalfRating = false,
//     this.icon,
//     this.initialRating,
//     this.itemPadding,
//     this.ignoreGestures = true,
//     required this.onRatingUpdate,
//   });
//   final bool allowHalfRating;
//   final String? icon;
//   final double? itemSize;
//   final double? initialRating;
//   final double? itemPadding;
//   final bool ignoreGestures;
//   final Function(double) onRatingUpdate;
//   @override
//   State<CustomRatingBar> createState() => _CustomRatingBarState();
// }

// class _CustomRatingBarState extends State<CustomRatingBar> {
//   @override
//   Widget build(BuildContext context) {
//     return RatingBar(
//       itemPadding: EdgeInsetsDirectional.only(end: widget.itemPadding ?? 6),
//       ignoreGestures: widget.ignoreGestures,
//       itemSize: widget.itemSize ?? 15.sp,
//       initialRating: widget.initialRating ?? 4.5,
//       minRating: 1,
//       direction: Axis.horizontal,
//       allowHalfRating: widget.allowHalfRating,
//       itemCount: 5,
//       ratingWidget: RatingWidget(
//         full: SvgPicture.asset(widget.icon ?? AppImages.assetsSvgFillStar),
//         half: SvgPicture.asset(widget.icon ?? AppImages.assetsSvgFillStar),
//         empty: SvgPicture.asset(AppImages.assetsSvgRatingStar),
//       ),
//       onRatingUpdate: widget.onRatingUpdate,
//     );
//   }
// }
