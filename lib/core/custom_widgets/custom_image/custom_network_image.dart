import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_hr_erb/core/images/app_images.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../routes/routes_name.dart';
import '../zoom_image/zoom_image_screen.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit? fit;
  final bool hasZoom;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.radius = 0,
    this.hasZoom = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasZoom
          ? () {
              context.pushNamed(
                RouteNames.zoomImage,
                extra: ZoomImageArgs(imageUrl: imageUrl),
              );
            }
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          width: width,
          height: height,
          placeholder: (context, url) =>
              const CupertinoActivityIndicator(color: AppColors.primary),
          errorWidget: (context, url, error) => Image(
            image: const AssetImage(AppImages.assetsImagesLogoPng),
            fit: fit,
            width: width,
            height: height,
          ),
        ),
      ),
    );
  }
}
