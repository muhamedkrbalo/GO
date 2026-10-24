import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/images/app_images.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../core/theme/app_sizes.dart';
import '../../../../../core/theme/extensions/theme_extensions.dart';
import '../../../data/model/onboarding_item.dart';
import '../../controller/onboarding_cubit.dart';
import '../widget/onboarding_bottom_bar.dart';
import '../widget/onboarding_header.dart';
import '../widget/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  bool _precached = false;

  static const _pagesTop = 84.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precached) return;
    _precached = true;
    for (final item in OnboardingItem.items) {
      precacheImage(AssetImage(item.image), context);
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
    final total = OnboardingItem.items.length;
    return Scaffold(
      backgroundColor: context.customColors.surfaceWarm,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: _pagesTop),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: total,
                    onPageChanged: context.read<OnboardingCubit>().pageChanged,
                    itemBuilder: (context, index) => OnboardingPage(
                      item: OnboardingItem.items[index],
                      index: index,
                      total: total,
                    ),
                  ),
                ),
                OnboardingBottomBar(controller: _pageController, onNext: _next, onFinish: _finish),
              ],
            ),
            PositionedDirectional(
              top: AppSpacing.xl20,
              start: AppSpacing.xxl24,
              end: AppSpacing.xxl24,
              child: OnboardingHeader(onSkip: _finish),
            ),
          ],
        ),
      ),
    );
  }
}
