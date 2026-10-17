import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hr_erb/core/images/app_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

class CachedNetworkSvgImage extends StatelessWidget {
  final String svgUrl;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit? fit;
  final Color? color;
  final VoidCallback? onTap;

  const CachedNetworkSvgImage({
    super.key,
    required this.svgUrl,
    this.width,
    this.height,
    this.fit,
    this.radius = 0,
    this.color,
    this.onTap,
    // required String url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkSVGImage(
          svgUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          color: color,
          placeholder: const CupertinoActivityIndicator(color: AppColors.primary),
          errorWidget: SvgPicture.asset(
            AppImages.assetsSvgGoLogo, // fallback SVG asset
            width: width,
            height: height,
            fit: fit ?? BoxFit.contain,
            color: color,
          ),
        ),
      ),
    );
  }
}
