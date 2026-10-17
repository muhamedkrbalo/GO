/// REST path fragments only. Base URL comes from [AppConfig] via [Dio] `baseUrl`.
class EndPoints {
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String verifyOtp = 'otp/verify';
  static const String categories = 'categories';
  static const String agents = 'companies';
  static const String auctions = 'auctions';
  static const String sliders = 'sliders';
  static const String assets = 'assets';
  static const String savedAuctionOrAsset = 'bookmarks';
  static String detailsAsset(int id) => 'assets/$id';
  static const String bids = 'bids';

  static const String autobids = 'autobids';
  static const String notifications = 'notifications';
  static String notificationsRead(String id) => 'notifications/$id';
  static String similarAssets(int id) => 'assets/$id/similar';
  static const String walletBalance = 'wallet';
  static const String assetMap = 'assets/map';
  static const String logout = 'auth/logout';
  static const String refreshToken = 'auth/refresh';
  static const String regions = 'regions/select';
  static const String alerts = 'alerts';
  static String alertById(int id) => 'alerts/$id';
  static String toggleAlert(int id) => 'alerts/$id/toggle';
  static const String paymentMethods = 'payment-methods';
  static const String banks = 'banks';
  static const String deposit = 'deposits';
  static const String withdrawals = 'withdrawals';
  static const String transactions = 'transactions';
  static const String makeOffer = 'offers';
  static const String buyNow = 'reservations';
  static const String addReminder = 'reminders';
  static const String createChat = 'chats';
  static String sendMessage(int id) => 'chats/$id/messages';
  static String getChat(int id) => 'chats/$id';
  static const String privacyPolicy = 'privacy-policy';
  static const String termsAndConditions = 'terms-conditions';
  static const String helpAndCenter = 'help-center';
  static const String contacts = 'settings/contacts';
  static const String profile = 'auth/me';
  static const String powerAttorneys = 'power-attorneys';
}
