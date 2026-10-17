import 'package:flutter/foundation.dart';

/// Stable keys for integration / E2E tests. Do not remove or rename without updating
/// `integration_test/flows/` and `specs/009-integration-e2e-flows/`.
class IntegrationKeys {
  IntegrationKeys._();

  static const ValueKey<String> loginScreen = ValueKey<String>('integration_login_screen');
  static const ValueKey<String> loginPhoneField = ValueKey<String>('integration_login_phone');
  static const ValueKey<String> loginPasswordField = ValueKey<String>('integration_login_password');
  static const ValueKey<String> loginSubmitButton = ValueKey<String>('integration_login_submit');

  static const ValueKey<String> verifyOtpPhoneScreen = ValueKey<String>(
    'integration_verify_otp_phone_screen',
  );
  static const ValueKey<String> otpField = ValueKey<String>('integration_otp_field');
  static const ValueKey<String> otpSubmitButton = ValueKey<String>('integration_otp_submit');

  static const ValueKey<String> homeScreen = ValueKey<String>('integration_home_screen');
  static const ValueKey<String> homeFilterBar = ValueKey<String>('integration_home_filter_bar');

  static const ValueKey<String> detailsAuctionScreen = ValueKey<String>('integration_details_auction_screen');
  static const ValueKey<String> bidOrAssetActionButton = ValueKey<String>('integration_bid_asset_action');

  static const ValueKey<String> walletScreen = ValueKey<String>('integration_wallet_screen');
  static const ValueKey<String> depositsScreen = ValueKey<String>('integration_deposits_screen');

  static const ValueKey<String> settingsLogout = ValueKey<String>('integration_settings_logout');
}
