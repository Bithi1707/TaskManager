import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/screens/add_new_taskScreen.dart';
import 'package:task_manager_project/ui/screens/change_password_screen.dart';
import 'package:task_manager_project/ui/screens/forget_pass_screen.dart';
import 'package:task_manager_project/ui/screens/main_nav_bar_holder.dart';
import 'package:task_manager_project/ui/screens/pin_verification_screen.dart';
import 'package:task_manager_project/ui/screens/progress_task_newList.dart';
import 'package:task_manager_project/ui/screens/sign_in_screen.dart';
import 'package:task_manager_project/ui/screens/sign_up_screen.dart';
import 'package:task_manager_project/ui/screens/splash_screen.dart';
import 'package:task_manager_project/ui/screens/update_profile_screen.dart';
class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static GlobalKey<NavigatorState> navigator=GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        textTheme: TextTheme(
          titleLarge: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 28
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
          hintStyle: TextStyle(
              color: Colors.grey
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green
          )
        )
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>SplashScreen(),
        '/sign-in':(context)=>SignInScreen(), 
        '/sign-up':(context)=>SignUpScreen(),
         '/forget-pass':(context)=>ForgetPassScreen(),
         '/pin-verification': (context) => PinVerificationScreen(),
         '/change-password': (context) => ChangePasswordScreen(),
        '/main_nav_bar_holder': (context) => MainNavBarHolder(),
         '/add_new_taskScreen' : (context)=>AddNewTaskscreen(),
        '/update_profile_Screen' : (context)=>UpdateProfileScreen(),

      },
    );
  }
}


