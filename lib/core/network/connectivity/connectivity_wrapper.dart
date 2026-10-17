import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hr_erb/core/locale/app_locale_key.dart';
import 'connectivity_cubit.dart';
import 'package:flutter_hr_erb/core/theme/app_text_styles.dart';
import 'package:flutter_hr_erb/core/theme/app_colors.dart';

/// A wrapper widget that displays a "No Internet" banner at the top of the screen
/// when the device loses internet connection.
class ConnectivityWrapper extends StatelessWidget {
  final Widget child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit, ConnectivityStatus>(
      builder: (context, status) {
        return Column(
          children: [
            // No Internet Banner
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: status == ConnectivityStatus.disconnected
                  ? MediaQuery.of(context).padding.top + 40
                  : 0,
              child: status == ConnectivityStatus.disconnected
                  ? NoInternetBanner(topPadding: MediaQuery.of(context).padding.top)
                  : const SizedBox.shrink(),
            ),
            // Main Content
            Expanded(child: child),
          ],
        );
      },
    );
  }
}

/// The banner widget shown when there's no internet connection
class NoInternetBanner extends StatelessWidget {
  final double topPadding;

  const NoInternetBanner({super.key, this.topPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.red.shade700,
      child: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: topPadding > 0 ? 0 : 8, bottom: 8, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, color: AppColors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                AppLocaleKey.noInternet.tr(),
                style: AppTextStyles.sMedium.copyWith(color: AppColors.white),
              ),
              const SizedBox(width: 8),
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
