
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      // if (HiveMethods.getToken() != "" &&
      //     HiveMethods.getToken() != null &&
      //     HiveMethods.getAuthModel()?.data?.user?.verificationStatus?.emailVerified == true &&
      //     HiveMethods.getAuthModel()?.data?.user?.verificationStatus?.phoneVerified == true) {
      //   if (mounted) Navigator.pushReplacementNamed(context, RoutesName.bottomNavBarScreen);
      //   return;
      // }
      // if (mounted) Navigator.pushReplacementNamed(context, RoutesName.chooseYourCountryScreen);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
