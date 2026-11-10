import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/model/verify_account_args.dart';
import '../../features/auth/data/model/verify_code_args.dart';
import '../../features/auth/presentation/controller/business_role_cubit.dart';
import '../../features/auth/presentation/controller/register_cubit.dart';
import '../../features/auth/presentation/controller/verify_account_cubit.dart';
import '../../features/auth/presentation/controller/verify_code_cubit.dart';
import '../../features/auth/presentation/view/screen/business_role_screen.dart';
import '../../features/auth/presentation/view/screen/login_screen.dart';
import '../../features/auth/presentation/view/screen/register_screen.dart';
import '../../features/auth/presentation/view/screen/verify_account_screen.dart';
import '../../features/auth/presentation/view/screen/verify_code_screen.dart';
import '../../features/broker_registration/data/model/broker_activation_checklist.dart';
import '../../features/broker_registration/data/model/broker_registration_receipt.dart';
import '../../features/broker_registration/data/model/broker_village_assignment.dart';
import '../../features/broker_registration/presentation/controller/broker_business_address_cubit.dart';
import '../../features/broker_registration/presentation/controller/broker_company_info_cubit.dart';
import '../../features/broker_registration/presentation/controller/broker_documents_cubit.dart';
import '../../features/broker_registration/presentation/controller/broker_identity_info_cubit.dart';
import '../../features/broker_registration/presentation/controller/broker_personal_info_cubit.dart';
import '../../features/broker_registration/presentation/controller/broker_registration_status_cubit.dart';
import '../../features/broker_registration/presentation/controller/broker_representative_cubit.dart';
import '../../features/broker_registration/presentation/controller/broker_type_cubit.dart';
import '../../features/broker_registration/presentation/controller/broker_village_selection_cubit.dart';
import '../../features/broker_registration/presentation/view/screen/broker_activation_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_business_address_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_business_contact_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_company_info_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_documents_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_identity_info_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_personal_info_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_registration_status_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_representative_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_review_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_submission_confirmation_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_type_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_village_assignments_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_village_endorsement_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_village_requests_submitted_screen.dart';
import '../../features/broker_registration/presentation/view/screen/broker_village_selection_screen.dart';
import '../../features/onboarding/presentation/controller/onboarding_cubit.dart';
import '../../features/onboarding/presentation/view/screen/onboarding_screen.dart';
import '../../features/onboarding/presentation/view/screen/welcome_screen.dart';
import '../../features/owner_home/presentation/view/screen/owner_home_screen.dart';
import '../../features/owner_navigation/data/model/owner_navigation_tab.dart';
import '../../features/owner_navigation/presentation/view/screen/owner_navigation_shell.dart';
import '../../features/owner_navigation/presentation/view/screen/owner_tab_placeholder_screen.dart';
import '../../features/owner_packages/data/model/owner_package.dart';
import '../../features/owner_packages/data/model/owner_subscription.dart';
import '../../features/owner_packages/data/model/sample_owner_subscription.dart';
import '../../features/owner_packages/presentation/controller/owner_packages_cubit.dart';
import '../../features/owner_packages/presentation/controller/package_payment_cubit.dart';
import '../../features/owner_packages/presentation/view/screen/owner_current_subscription_screen.dart';
import '../../features/owner_packages/presentation/view/screen/owner_package_confirmation_screen.dart';
import '../../features/owner_packages/presentation/view/screen/owner_package_details_screen.dart';
import '../../features/owner_packages/presentation/view/screen/owner_package_payment_screen.dart';
import '../../features/owner_packages/presentation/view/screen/owner_packages_screen.dart';
import '../../features/owner_packages/presentation/view/screen/owner_subscription_cancellation_screen.dart';
import '../../features/owner_registration/data/model/owner_unit.dart';
import '../../features/owner_registration/data/model/registration_receipt.dart';
import '../../features/owner_registration/data/model/unit_review.dart';
import '../../features/owner_registration/presentation/controller/company_info_cubit.dart';
import '../../features/owner_registration/presentation/controller/individual_info_cubit.dart';
import '../../features/owner_registration/presentation/controller/owner_address_cubit.dart';
import '../../features/owner_registration/presentation/controller/owner_documents_cubit.dart';
import '../../features/owner_registration/presentation/controller/owner_registration_draft_cubit.dart';
import '../../features/owner_registration/presentation/controller/owner_type_cubit.dart';
import '../../features/owner_registration/presentation/controller/ownership_details_cubit.dart';
import '../../features/owner_registration/presentation/controller/registration_review_cubit.dart';
import '../../features/owner_registration/presentation/controller/registration_status_cubit.dart';
import '../../features/owner_registration/presentation/controller/selected_units_review_cubit.dart';
import '../../features/owner_registration/presentation/controller/unit_selection_cubit.dart';
import '../../features/owner_registration/presentation/view/screen/company_info_screen.dart';
import '../../features/owner_registration/presentation/view/screen/individual_info_screen.dart';
import '../../features/owner_registration/presentation/view/screen/owner_address_screen.dart';
import '../../features/owner_registration/presentation/view/screen/owner_documents_screen.dart';
import '../../features/owner_registration/presentation/view/screen/owner_type_screen.dart';
import '../../features/owner_registration/presentation/view/screen/ownership_details_screen.dart';
import '../../features/owner_registration/presentation/view/screen/registration_review_screen.dart';
import '../../features/owner_registration/presentation/view/screen/registration_status_screen.dart';
import '../../features/owner_registration/presentation/view/screen/selected_units_review_screen.dart';
import '../../features/owner_registration/presentation/view/screen/submission_confirmation_screen.dart';
import '../../features/owner_registration/presentation/view/screen/unit_review_details_screen.dart';
import '../../features/owner_registration/presentation/view/screen/unit_selection_screen.dart';
import '../../features/splash/presentation/view/screen/splash_screen.dart';
import '../auth/auth_session.dart';
import '../cache/hive/hive_methods.dart';
import '../custom_widgets/zoom_image/zoom_image_screen.dart';
import '../services/service_locator.dart';
import 'routes_name.dart';

class AppRouters {
  /// Owned by the router. Don't use `navigatorKey.currentContext` in helpers:
  /// pass a [BuildContext] (see `context_ui_extension.dart`) instead.
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static final AuthSession _authSession = sl<AuthSession>();

  // UI PREVIEW SWITCH
  // true  → after the splash the app always opens the owner bottom navigation (Home tab),
  //         even when signed out. Use this while building the UI.
  // false → normal auth flow: signed out goes to onboarding/welcome, signed in goes to Home.
  // To restore the real flow, set this to false. Nothing else needs to change.
  static bool previewOwnerNavigation = true;

  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: RoutePaths.splash,
    observers: [BotToastNavigatorObserver()],
    refreshListenable: _authSession,
    redirect: _authRedirect,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OnboardingCubit>(),
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.welcome,
        name: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<RegisterCubit>(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.verifyAccount,
        name: RouteNames.verifyAccount,
        redirect: (context, state) =>
            state.extra is VerifyAccountArgs ? null : RoutePaths.register,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<VerifyAccountCubit>(),
          child: VerifyAccountScreen(args: state.extra! as VerifyAccountArgs),
        ),
      ),
      GoRoute(
        path: RoutePaths.verifyCode,
        name: RouteNames.verifyCode,
        redirect: (context, state) => state.extra is VerifyCodeArgs ? null : RoutePaths.register,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<VerifyCodeCubit>()..startCountdown(),
          child: VerifyCodeScreen(args: state.extra! as VerifyCodeArgs),
        ),
      ),
      GoRoute(
        path: RoutePaths.businessRole,
        name: RouteNames.businessRole,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BusinessRoleCubit>(),
          child: const BusinessRoleScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.ownerType,
        name: RouteNames.ownerType,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OwnerTypeCubit>(),
          child: const OwnerTypeScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerType,
        name: RouteNames.brokerType,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerTypeCubit>(),
          child: const BrokerTypeScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerPersonalInfo,
        name: RouteNames.brokerPersonalInfo,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerPersonalInfoCubit>(),
          child: const BrokerPersonalInfoScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerCompanyInfo,
        name: RouteNames.brokerCompanyInfo,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerCompanyInfoCubit>(),
          child: const BrokerCompanyInfoScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerIdentityInfo,
        name: RouteNames.brokerIdentityInfo,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerIdentityInfoCubit>(),
          child: const BrokerIdentityInfoScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerRepresentative,
        name: RouteNames.brokerRepresentative,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerRepresentativeCubit>(),
          child: const BrokerRepresentativeScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerBusinessAddress,
        name: RouteNames.brokerBusinessAddress,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerBusinessAddressCubit>(),
          child: const BrokerBusinessAddressScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerBusinessContact,
        name: RouteNames.brokerBusinessContact,
        builder: (context, state) => const BrokerBusinessContactScreen(),
      ),
      GoRoute(
        path: RoutePaths.brokerDocuments,
        name: RouteNames.brokerDocuments,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerDocumentsCubit>(),
          child: const BrokerDocumentsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerReview,
        name: RouteNames.brokerReview,
        builder: (context, state) => const BrokerReviewScreen(),
      ),
      GoRoute(
        path: RoutePaths.brokerSubmitted,
        name: RouteNames.brokerSubmitted,
        redirect: (context, state) =>
            state.extra is BrokerRegistrationReceipt ? null : RoutePaths.home,
        builder: (context, state) =>
            BrokerSubmissionConfirmationScreen(receipt: state.extra! as BrokerRegistrationReceipt),
      ),
      GoRoute(
        path: RoutePaths.brokerRegistrationStatus,
        name: RouteNames.brokerRegistrationStatus,
        redirect: (context, state) =>
            state.extra is BrokerRegistrationReceipt ? null : RoutePaths.home,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerRegistrationStatusCubit>(
            param1: state.extra! as BrokerRegistrationReceipt,
          ),
          child: const BrokerRegistrationStatusScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerVillageSelection,
        name: RouteNames.brokerVillageSelection,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<BrokerVillageSelectionCubit>(),
          child: const BrokerVillageSelectionScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerVillageRequestsSubmitted,
        name: RouteNames.brokerVillageRequestsSubmitted,
        redirect: (context, state) => state.extra is List<BrokerVillageAssignment>
            ? null
            : RoutePaths.brokerVillageSelection,
        builder: (context, state) => BrokerVillageRequestsSubmittedScreen(
          assignments: state.extra! as List<BrokerVillageAssignment>,
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerVillageAssignments,
        name: RouteNames.brokerVillageAssignments,
        redirect: (context, state) => state.extra is List<BrokerVillageAssignment>
            ? null
            : RoutePaths.brokerVillageSelection,
        builder: (context, state) => BrokerVillageAssignmentsScreen(
          assignments: state.extra! as List<BrokerVillageAssignment>,
        ),
      ),
      GoRoute(
        path: RoutePaths.brokerVillageEndorsement,
        name: RouteNames.brokerVillageEndorsement,
        redirect: (context, state) =>
            state.extra is BrokerVillageAssignment ? null : RoutePaths.brokerVillageSelection,
        builder: (context, state) =>
            BrokerVillageEndorsementScreen(assignment: state.extra! as BrokerVillageAssignment),
      ),
      GoRoute(
        path: RoutePaths.brokerActivation,
        name: RouteNames.brokerActivation,
        redirect: (context, state) =>
            state.extra is BrokerActivationChecklist ? null : RoutePaths.brokerVillageSelection,
        builder: (context, state) =>
            BrokerActivationScreen(checklist: state.extra! as BrokerActivationChecklist),
      ),
      GoRoute(
        path: RoutePaths.individualInfo,
        name: RouteNames.individualInfo,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<IndividualInfoCubit>(),
          child: const IndividualInfoScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.companyInfo,
        name: RouteNames.companyInfo,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<CompanyInfoCubit>(),
          child: const CompanyInfoScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.ownerAddress,
        name: RouteNames.ownerAddress,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OwnerAddressCubit>(),
          child: const OwnerAddressScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.unitSelection,
        name: RouteNames.unitSelection,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<UnitSelectionCubit>(),
          child: const UnitSelectionScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.selectedUnitsReview,
        name: RouteNames.selectedUnitsReview,
        redirect: (context, state) =>
            state.extra is List<OwnerUnit> ? null : RoutePaths.unitSelection,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SelectedUnitsReviewCubit>(param1: state.extra! as List<OwnerUnit>),
          child: const SelectedUnitsReviewScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.ownershipDetails,
        name: RouteNames.ownershipDetails,
        redirect: (context, state) =>
            state.extra is List<OwnerUnit> ? null : RoutePaths.unitSelection,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OwnershipDetailsCubit>(param1: state.extra! as List<OwnerUnit>),
          child: const OwnershipDetailsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.ownerDocuments,
        name: RouteNames.ownerDocuments,
        redirect: (context, state) =>
            state.extra is List<OwnerUnit> ? null : RoutePaths.unitSelection,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OwnerDocumentsCubit>(param1: state.extra! as List<OwnerUnit>),
          child: const OwnerDocumentsScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.registrationReview,
        name: RouteNames.registrationReview,
        redirect: (context, state) =>
            sl<OwnerRegistrationDraftCubit>().state.units.isEmpty ? RoutePaths.ownerType : null,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<RegistrationReviewCubit>(),
          child: const RegistrationReviewScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.registrationSubmitted,
        name: RouteNames.registrationSubmitted,
        redirect: (context, state) =>
            state.extra is RegistrationReceipt ? null : RoutePaths.home,
        builder: (context, state) =>
            SubmissionConfirmationScreen(receipt: state.extra! as RegistrationReceipt),
      ),
      GoRoute(
        path: RoutePaths.registrationStatus,
        name: RouteNames.registrationStatus,
        redirect: (context, state) =>
            state.extra is RegistrationReceipt ? null : RoutePaths.home,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<RegistrationStatusCubit>(param1: state.extra! as RegistrationReceipt),
          child: const RegistrationStatusScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.unitReviewDetails,
        name: RouteNames.unitReviewDetails,
        redirect: (context, state) => state.extra is UnitReview ? null : RoutePaths.home,
        builder: (context, state) => UnitReviewDetailsScreen(review: state.extra! as UnitReview),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            OwnerNavigationShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.home,
                name: RouteNames.home,
                builder: (context, state) => const OwnerHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ownerUnits,
                name: RouteNames.ownerUnits,
                builder: (context, state) =>
                    const OwnerTabPlaceholderScreen(tab: OwnerNavigationTab.units),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ownerSubscription,
                name: RouteNames.ownerSubscription,
                builder: (context, state) => OwnerCurrentSubscriptionScreen(
                  subscription: sampleOwnerSubscription,
                  showBackButton: false,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePaths.ownerMore,
                name: RouteNames.ownerMore,
                builder: (context, state) =>
                    const OwnerTabPlaceholderScreen(tab: OwnerNavigationTab.more),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RoutePaths.ownerPackages,
        name: RouteNames.ownerPackages,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<OwnerPackagesCubit>(),
          child: const OwnerPackagesScreen(),
        ),
      ),
      GoRoute(
        path: RoutePaths.ownerPackageDetails,
        name: RouteNames.ownerPackageDetails,
        redirect: (context, state) =>
            state.extra is OwnerPackage ? null : RoutePaths.ownerPackages,
        builder: (context, state) =>
            OwnerPackageDetailsScreen(package: state.extra! as OwnerPackage),
      ),
      GoRoute(
        path: RoutePaths.ownerPackageConfirmation,
        name: RouteNames.ownerPackageConfirmation,
        redirect: (context, state) =>
            state.extra is OwnerPackage ? null : RoutePaths.ownerPackages,
        builder: (context, state) =>
            OwnerPackageConfirmationScreen(package: state.extra! as OwnerPackage),
      ),
      GoRoute(
        path: RoutePaths.ownerSubscriptionCancellation,
        name: RouteNames.ownerSubscriptionCancellation,
        redirect: (context, state) =>
            state.extra is OwnerSubscription ? null : RoutePaths.ownerSubscription,
        builder: (context, state) =>
            OwnerSubscriptionCancellationScreen(subscription: state.extra! as OwnerSubscription),
      ),
      GoRoute(
        path: RoutePaths.ownerPackagePayment,
        name: RouteNames.ownerPackagePayment,
        redirect: (context, state) =>
            state.extra is OwnerPackage ? null : RoutePaths.ownerPackages,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<PackagePaymentCubit>(),
          child: OwnerPackagePaymentScreen(package: state.extra! as OwnerPackage),
        ),
      ),
      GoRoute(
        path: RoutePaths.zoomImage,
        name: RouteNames.zoomImage,
        // `extra` is null on deep links, web refresh and state restoration.
        redirect: (context, state) =>
            state.extra is ZoomImageArgs ? null : RoutePaths.home,
        builder: (context, state) => ZoomImageScreen(
          args: state.extra as ZoomImageArgs,
        ),
      ),
    ],
  );

  /// Screens a signed-out user may stay on.
  static const _signedOutPaths = {
    RoutePaths.onboarding,
    RoutePaths.welcome,
    RoutePaths.login,
    RoutePaths.register,
    RoutePaths.verifyAccount,
    RoutePaths.verifyCode,
    RoutePaths.businessRole,
    RoutePaths.ownerType,
    RoutePaths.individualInfo,
    RoutePaths.companyInfo,
    RoutePaths.ownerAddress,
    RoutePaths.unitSelection,
    RoutePaths.selectedUnitsReview,
    RoutePaths.ownershipDetails,
    RoutePaths.ownerDocuments,
    RoutePaths.registrationReview,
    RoutePaths.registrationSubmitted,
    RoutePaths.registrationStatus,
    RoutePaths.unitReviewDetails,
    RoutePaths.brokerType,
    RoutePaths.brokerPersonalInfo,
    RoutePaths.brokerCompanyInfo,
    RoutePaths.brokerIdentityInfo,
    RoutePaths.brokerRepresentative,
    RoutePaths.brokerBusinessAddress,
    RoutePaths.brokerBusinessContact,
    RoutePaths.brokerDocuments,
    RoutePaths.brokerReview,
    RoutePaths.brokerSubmitted,
    RoutePaths.brokerRegistrationStatus,
    RoutePaths.brokerVillageSelection,
    RoutePaths.brokerVillageRequestsSubmitted,
    RoutePaths.brokerVillageAssignments,
    RoutePaths.brokerVillageEndorsement,
    RoutePaths.brokerActivation,
  };

  /// Login gating, in one place:
  /// - unknown (restoring session) → splash
  /// - signed out → onboarding (first launch) or welcome; may also open login
  /// - signed in → anywhere except splash and the signed-out screens (those go to home)
  static String? _authRedirect(BuildContext context, GoRouterState state) {
    final location = state.matchedLocation;
    switch (_authSession.value) {
      case AuthStatus.unknown:
        return location == RoutePaths.splash ? null : RoutePaths.splash;
      case AuthStatus.unauthenticated:
        // UI PREVIEW: skip onboarding/welcome and land on the bottom navigation.
        // Controlled by [previewOwnerNavigation] above.
        if (previewOwnerNavigation) {
          return location == RoutePaths.splash ? RoutePaths.home : null;
        }
        if (_signedOutPaths.contains(location)) return null;
        return HiveMethods.isFirstTime() ? RoutePaths.onboarding : RoutePaths.welcome;
      case AuthStatus.authenticated:
        return location == RoutePaths.splash || _signedOutPaths.contains(location)
            ? RoutePaths.home
            : null;
    }
  }
}
