import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/onboarding_item.dart';
import '../../controller/onboarding_cubit.dart';
import '../widget/onboarding_bottom_bar.dart';
import '../widget/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  bool _precached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precached) return;
    _precached = true;
    for (final item in OnboardingItem.items) {
      final loader = SvgAssetLoader(item.illustration);
      svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
    precacheImage(const AssetImage(AppImages.assetsImagesWelcome), context);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() => _pageController.nextPage(
    duration: const Duration(milliseconds: 350),
    curve: Curves.easeOutCubic,
  );

  void _finish() {
    context.read<OnboardingCubit>().complete();
    context.go(RoutePaths.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.customColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: OnboardingItem.items.length,
                onPageChanged: context.read<OnboardingCubit>().pageChanged,
                itemBuilder: (context, index) =>
                    OnboardingPage(item: OnboardingItem.items[index], index: index),
              ),
            ),
            OnboardingBottomBar(controller: _pageController, onNext: _next, onFinish: _finish),
          ],
        ),
      ),
    );
  }
}
