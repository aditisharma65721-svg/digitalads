import 'package:digitalads/views/screens/Advertiser/advertiser_deashboard/advertiser_deshboard_screen.dart';
import 'package:digitalads/views/screens/Reviewer/reviewerDashboard/reviewer_dashboard_screen.dart';
import 'package:digitalads/views/screens/auth/create_account_screen.dart';
import 'package:digitalads/views/screens/auth/forgot_pass_screen.dart';
import 'package:digitalads/views/screens/auth/loginScreen.dart';
import 'package:digitalads/views/screens/auth/otp_screen.dart';
import 'package:digitalads/views/screens/storeApp/booking/booking_details_screen.dart';
import 'package:digitalads/views/screens/storeApp/booking/bookings_screen.dart';
import 'package:digitalads/views/screens/storeApp/deshboard/deshboard_screen.dart';
import 'package:digitalads/views/screens/storeApp/profile/change_password_screen.dart';
import 'package:digitalads/views/screens/storeApp/profile/edit_profile.dart';
import 'package:digitalads/views/screens/storeApp/profile/payment_methods_screen.dart';
import 'package:digitalads/views/screens/storeApp/profile/payout_history_screen.dart';
import 'package:digitalads/views/screens/storeApp/profile/stripe_verification_screen.dart';
import 'package:digitalads/views/screens/storeApp/profile/subscription.dart';
import 'package:digitalads/views/screens/storeApp/profile/transaction_history_screen.dart';
import 'package:digitalads/views/screens/storeApp/screenPage/screen_page.dart';
import 'package:digitalads/views/screens/splash/onboarding/onboarding1.dart';
import 'package:digitalads/views/screens/splash/onboarding/onboarding2.dart';
import 'package:digitalads/views/screens/splash/onboarding/onboarding3.dart';
import 'package:digitalads/views/screens/splash/splash.dart';
import 'package:digitalads/views/screens/auth/user_role_screen.dart';
import 'package:digitalads/views/screens/storeApp/store/add_screen_details_screen.dart';
import 'package:digitalads/views/screens/storeApp/store/create_store_location_screen.dart';
import 'package:digitalads/views/screens/storeApp/store/store_availability_screen.dart';
import 'package:digitalads/views/screens/storeApp/store/store_details_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const splashScreen = "splash";
  static const onBoardingScreen1 = "onBoardingScreen1";
  static const onBoardingScreen2 = "onBoardingScreen2";
  static const onBoardingScreen3 = "onBoardingScreen3";
  static const loginScreen = "login";
  static const forgotPass = "forgotPass";
  static const userRole = "userRole";
  static const createAccountScreen = "createAccountScreen";
  static const oTPVerification = "oTPVerification ";
  static const deshboardScreen = "deshboardScreen ";
  static const editProfile = "editProfileScreen ";
  static const notificationScreen = "notificationScreen ";
  static const bookingsScreen = "bookingsScreen ";
  static const bookingDetails = "bookingDetails ";
  static const screenPage = "screenPage";
  static const subsCription = "subsCription";
  static const stripeVerificationScreen = "stripeVerificationScreen";
  static const paymentMethodsScreen = "paymentMethodsScreen";
  static const transactionHistoryScreen = "transactionHistoryScreen";
  static const payoutHistoryScreen = "payoutHistoryScreen";
  static const changePasswordScreen = "changePasswordScreen";
  static const createStoreLocationScreen = "createStoreLocationScreen";
  static const storeAvailabilityScreen = "storeAvailabilityScreen";
  static const addScreenDetailsScreen = "AddScreenDetailsScreen";
  static const storeDetailsScreen = "storeDetailsScreen";

  // reviewer
  static const reviewerDashboard = "reviewerDashboard";

  //advertiser
  static const advertiserDashboard = "advertiserDashboard";

  static Map<String, Widget Function(BuildContext context)> routes = {
    splashScreen: (context) => const SplashScreen(),
    onBoardingScreen1: (context) => const OnboardingScreen1(),
    onBoardingScreen2: (context) => const OnboardingScreen2(),
    onBoardingScreen3: (context) => const OnboardingScreen3(),
    loginScreen: (context) => const LoginScreen(),
    forgotPass: (context) => const ForgotPasswordScreen(),
    userRole: (context) => ChooseRoleScreen(),
    createAccountScreen: (context) => CreateAccountScreen(userType: ""),
    oTPVerification: (context) =>
        OtpVerificationScreen(email: '', userRole: ""),
    deshboardScreen: (context) => DashboardScreen(),
    editProfile: (context) => EditProfileScreen(),
    // notificationScreen: (context) => NotificationScreen(),
    bookingsScreen: (context) => BookingsScreen(),
    bookingDetails: (context) => BookingDetailsScreen(),
    screenPage: (context) => ScreensPage(),
    subsCription: (context) => SubscriptionScreen(),
    stripeVerificationScreen: (context) => StripeVerificationScreen(),
    paymentMethodsScreen: (context) => PaymentMethodsScreen(),
    transactionHistoryScreen: (context) => TransactionHistoryScreen(),
    payoutHistoryScreen: (context) => PayoutHistoryScreen(),
    changePasswordScreen: (context) => ChangePasswordScreen(),
    createStoreLocationScreen: (context) => CreateStoreLocationScreen(),
    storeAvailabilityScreen: (context) => StoreAvailabilityScreen(),
    addScreenDetailsScreen: (context) => AddScreenDetailsScreen(),
    storeDetailsScreen: (context) => StoreLocationDetailsScreen(),
    advertiserDashboard: (context) => AdvertiserDashboardScreen(),
  };
}
