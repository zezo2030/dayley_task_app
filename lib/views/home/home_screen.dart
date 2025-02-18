import 'package:dayley_task_app/routes/pages.dart';
import 'package:dayley_task_app/utils/color_palette.dart';
import 'package:dayley_task_app/viewmodel/task_view_model.dart';
import 'package:dayley_task_app/widgets/moder_task_view.dart';
import 'package:dayley_task_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // create a reference to the TaskViewModel
    final TaskViewModel taskViewModel = Provider.of<TaskViewModel>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: ScaffoldMessenger(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: kWhiteColor,
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    context.locale.languageCode.toUpperCase(),
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () {
                  context.setLocale(context.locale.languageCode == 'ar'
                      ? const Locale('en')
                      : const Locale('ar'));
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          backgroundColor: kGrey4,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: taskViewModel.tasks.isEmpty
                ? _imptyTaskList(height: size.height * .20, width: size.width)
                : ModerTaskView(),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Pages.createTask);
            },
            //backgroundColor: kPrimaryColor,
            child: const Icon(
              Icons.add_circle,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _imptyTaskList({double? height, double? width}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svgs/tasks.svg',
            height: height,
            width: width,
          ),
          const SizedBox(
            height: 50,
          ),
          buildText('scheduleTasks'.tr(), kBlackColor, 30, FontWeight.w600,
              TextAlign.center, TextOverflow.clip),
          buildText(
            'manageTasksDesc'.tr(),
            kBlackColor.withOpacity(.5),
            12,
            FontWeight.normal,
            TextAlign.center,
            TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
