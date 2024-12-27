import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PageNotFound extends StatefulWidget {
  const PageNotFound({super.key});

  @override
  State<PageNotFound> createState() => _PageNotFoundState();
}

class _PageNotFoundState extends State<PageNotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteColor,
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildText('Page not found', kBlackColor, 30, FontWeight.w600,
                TextAlign.center, TextOverflow.clip),
            const SizedBox(
              height: 10,
            ),
            buildText('Something went wrong', kBlackColor, 10,
                FontWeight.normal, TextAlign.center, TextOverflow.clip),
          ],
        )));
  }
}
