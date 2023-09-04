import 'package:flutter/material.dart';
import 'package:hire_pro/screens/Job/progress.dart';
import 'package:hire_pro/screens/Profile/editCategories.dart';
import 'package:hire_pro/screens/Profile/viewReviews.dart';
import 'package:hire_pro/screens/calender.dart';
import 'package:hire_pro/screens/homeScreen.dart';
import 'package:hire_pro/screens/otpPhoneEnterScreen.dart';
import 'package:hire_pro/screens/Authentication/registerSuccess.dart';
import 'package:hire_pro/screens/Authentication/loginScreen.dart';
import 'package:hire_pro/screens/Authentication/signUpScreen.dart';
import 'package:hire_pro/screens/Authentication/selectCategories.dart';
import 'package:hire_pro/screens/otpPhoneScreen.dart';
import 'package:hire_pro/screens/Authentication/verificationScreen.dart';
import 'package:hire_pro/screens/Authentication/uploadProfilePicture.dart';
import 'package:hire_pro/screens/Authentication/forgotPassword.dart';
import 'package:hire_pro/screens/Authentication/resetPassword.dart';
import 'package:hire_pro/screens/Job/jobCompletedScreen.dart';
import 'package:hire_pro/screens/Job/earnedStarsScreen.dart';
import 'package:hire_pro/screens/Job/rateCustomerScreen.dart';
import 'package:hire_pro/screens/Job/biddingRequestScreen.dart';
import 'package:hire_pro/screens/Job/biddingTasks.dart';
import 'package:hire_pro/screens/Job/startJobScreen.dart';
import 'package:hire_pro/screens/waitingScreen.dart';
import 'package:hire_pro/screens/Job/biddingSuccessfulScreen.dart';
import 'package:hire_pro/screens/Job/viewRatesScreen.dart';
import 'package:hire_pro/screens/Job/biddingRequestScreen.dart';
import 'package:hire_pro/screens/Job/progressStepOne.dart';
import 'package:hire_pro/screens/Job/progressStepTwo.dart';
import 'package:hire_pro/screens/Job/progressStepThree.dart';
import 'package:hire_pro/screens/Profile/userProfile.dart';
import 'package:hire_pro/screens/Profile/customerProfile.dart';
import 'package:hire_pro/screens/Profile/editProfile.dart';
import 'package:hire_pro/screens/Profile/viewReviews.dart';
import 'package:hire_pro/screens/Profile/addCategory.dart';
import 'package:hire_pro/screens/emailcodereqScreen.dart';
import 'package:hire_pro/screens/Profile/changePassword.dart';
import 'package:hire_pro/screens/emailCodeVerifyScreen.dart';
import 'package:hire_pro/screens/Profile/changePassword.dart';
import 'package:hire_pro/screens/Profile/reviews.dart';
import 'package:hire_pro/services/calander.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/screens/agreement.dart';
import 'package:hire_pro/screens/ongoingTasks.dart';
import 'package:hire_pro/screens/upcomingTasks.dart';
import 'package:hire_pro/screens/completedTasks.dart';
import 'package:hire_pro/screens/Job/startJobScreen.dart';
import 'package:hire_pro/screens/wallet.dart';
// import 'package:hire_pro/screens/viewTaskDetails.dart';

void main() {
  runApp(const HirePro());
}

class HirePro extends StatelessWidget {
  const HirePro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          primaryColorDark: Color.fromARGB(1, 245, 245, 245),
          fontFamily: 'Roboto',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72),
            titleLarge: TextStyle(fontSize: 36),
            bodyMedium: TextStyle(fontSize: 14),
          ),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Color(0xFFD4842B))),
      initialRoute: '/',
      routes: {
        // '/': (context) => ProgressStart(),
        '/': (context) => LoginScreen(),
        // '/': (context) => VerificationScreen(),
        '/home': (context) => HomeScreen(),
        '/sign_up': (context) => SignUpScreen(),
        '/registrationSuccess': (context) => RegisterSuccess(),
        '/profile': (context) => UserProfile(),
        '/edit_profile': (context) => EditProfile(),
        '/emailcoderequest': (context) => EmailcodereqScreen(),
        '/emailcodeverify': (context) => EmailCodeVerifyScreen(),
        '/otp_mobile': (context) => OTPPhone(),
        '/otp_enter': (context) =>OtpEnterScreen(),
        '/changePassword': (context) => ChangePassword(),
        '/upload_verified_documents': (context) =>VerificationScreen(),
        '/registration_success': (context) =>RegisterSuccess(),
        '/upload_profile_picture': (context) =>UploadProfilePicture(),
        '/ongoing_tasks': (context) => OngoingTasks(),
        '/upcoming_tasks': (context) => UpcomingTasks(),
        '/completed_tasks': (context) => CompletedTasks(),
        // '/bidding_request': (context) => BiddingRequest(),
        '/bidding_successful': (context) => BiddingSuccessfulScreen(),
        '/customer_profile': (context) => CustomerProfile(),
        '/bidding_tasks': (context) => BiddingTasks(),
        '/start_job': (context) => StartJob(),
        '/progress_start': (context) => ProgressStart(),
        '/progress_step_one': (context) => ProgressStepOne(),
        '/progress_step_two': (context) => ProgressStepTwo(),
        '/progress_step_three': (context) => ProgressStepThree(),
        '/job_completed': (context) => JobCompletedScreen(),
        '/earned_ratings': (context) => EarnedStarsScreen(),
        '/rate_customer': (context) => RateCustomerScreen(),
        '/view_rated': (context) => ViewRatedScreen(),
        '/select_categories': (context) => SelectCategories(),
        // '/view_task_details': (context) => ViewTaskDetails(),
        '/view_wallet': (context) => Wallet(),
        '/view_reviews': (context) => ViewReviews(),
        '/forgot_password': (context) => ForgotPassword(),
        '/reset_password': (context) => ResetPassword(),
        '/calender': (context) => CalenderScreen(),
        '/add_category': (context) => AddCategory(),
        '/edit_categories': (context) => EditCategories(),

      },
    );
  }
}
