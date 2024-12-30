import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushNamed(context, Pages.home);

      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/app_logo.png',
              width: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            buildText(
              'welcomeMessage'.tr(),
              kWhiteColor,
              30,
              FontWeight.w600,
              TextAlign.center,
              TextOverflow.clip,
            ),
            const SizedBox(
              height: 10,
            ),
            buildText(
              'appDescription'.tr(),
              kWhiteColor,
              10,
              FontWeight.normal,
              TextAlign.center,
              TextOverflow.clip,
            ),
          ],
        ),
      ),
    );
  }
}
