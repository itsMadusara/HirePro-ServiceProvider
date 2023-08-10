import 'package:flutter/material.dart';
import 'package:hire_pro/screens/homeScreen.dart';
import 'package:hire_pro/screens/Authentication/otpEnterScreen.dart';
import 'package:hire_pro/screens/Authentication/registerSuccess.dart';
import 'package:hire_pro/screens/Authentication/loginScreen.dart';
import 'package:hire_pro/screens/Authentication/signUpScreen.dart';
import 'package:hire_pro/screens/Authentication/otpScreen.dart';
import 'package:hire_pro/screens/Authentication/verificationScreen.dart';
import 'package:hire_pro/screens/Job/jobCompletedScreen.dart';
import 'package:hire_pro/screens/Job/earnedStarsScreen.dart';
import 'package:hire_pro/screens/Job/rateCustomerScreen.dart';
import 'package:hire_pro/screens/waitingScreen.dart';
import 'package:hire_pro/screens/Job/biddingSuccessfulScreen.dart';
import 'package:hire_pro/screens/Job/viewRatesScreen.dart';
import 'package:hire_pro/screens/Profile/userProfile.dart';
import 'package:hire_pro/screens/Profile/customerProfile.dart';
import 'package:hire_pro/screens/Profile/editProfile.dart';
import 'package:hire_pro/screens/emailcodereqScreen.dart';
import 'package:hire_pro/screens/Profile/changePassword.dart';
import 'package:hire_pro/screens/emailCodeVerifyScreen.dart';
import 'package:hire_pro/screens/Profile/changePassword.dart';
import 'package:hire_pro/screens/Profile/reviews.dart';
import 'package:hire_pro/widgets/TopNavigation.dart';
import 'package:hire_pro/screens/agreement.dart';

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
        // '/': (context) => ViewRatedScreen(),
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/sign_up': (context) => SignUpScreen(),
        // '/': (context) => EditProfile(),
        '/profile': (context) => UserProfile(),
        '/emailcoderequest': (context) => EmailcodereqScreen(),
        '/emailcodeverify': (context) => EmailCodeVerifyScreen(),
        '/changePassword': (context) => ChangePassword(),
      },
    );
  }
}
